local M = {}

local state = { buffer_number = nil, window_number = nil }

function M.open_build_window()
  -- Reuse the window if it is still on screen.
  if state.window_number and vim.api.nvim_win_is_valid(state.window_number) then return state.window_number end

  -- Create the scratch buffer once, reuse it afterwards.
  if not (state.buffer_number and vim.api.nvim_buf_is_valid(state.buffer_number)) then
    state.buffer_number = vim.api.nvim_create_buf(false, true)
    vim.bo[state.buffer_number].buftype = 'nofile'
    vim.bo[state.buffer_number].bufhidden = 'hide'
    vim.bo[state.buffer_number].swapfile = false
    -- NOTE: remove this for now
    -- vim.bo[state.buffer_number].filetype = "zigbuild"
  end

  local target_width = math.floor(vim.o.columns / 4)

  state.window_number = vim.api.nvim_open_win(state.buffer_number, false, {
    split = 'right',
    win = -1, -- -1 means: split relative to the whole tabpage, not the current window
    width = target_width,
  })

  vim.wo[state.window_number].number = false
  vim.wo[state.window_number].relativenumber = false
  vim.wo[state.window_number].signcolumn = 'no'
  vim.wo[state.window_number].wrap = false
  vim.wo[state.window_number].winfixwidth = true

  -- NOTE: I don't think I want to forget if closed.
  --
  -- -- Forget the handle when the user closes the window themselves.
  -- vim.api.nvim_create_autocmd("WinClosed", {
  --   pattern = tostring(state.window_number),
  --   once = true,
  --   callback = function()
  --     state.window_number = nil
  --   end,
  -- })

  return state.window_number
end

local function to_lines(str) return vim.split(str, '\n', { trimempty = false }) end

local function on_exit(obj)
  vim.schedule(function()
    vim.bo[state.buffer_number].modifiable = true
    local stdout = to_lines(obj.stdout)
    local stderr = to_lines(obj.stderr)
    local output = { 'Outputs:', 'Stdout:' }
    vim.list_extend(output, stdout)
    vim.list_extend(output, { '', 'Stderr:' })
    vim.list_extend(output, stderr)

    -- DO parsing as well
    local parser = require 'custom.zig-watcher.parser'
    vim.print(parser.parse_diagnostics(stderr))
    -- vim.list_extend(output, { '', 'Parsed output:' })
    -- vim.list_extend(output,  parser.parse_diagnostics(stderr) )

    vim.api.nvim_buf_set_lines(state.buffer_number, 0, -1, false, output)
  end)
end

function M.cmd_to_buf(cmd, opts)
  if not state.buffer_number then return end

  opts = opts or {}
  -- TODO: add text = true -> need to check what it does

  vim.system(cmd, opts, on_exit)
end

-- NOTE: Commands
vim.api.nvim_create_user_command('WindowView', function()
  if not state.window_number or not vim.api.nvim_win_is_valid(state.window_number) then
    state.window_number = M.open_build_window()
  else
    vim.api.nvim_win_hide(state.window_number)
  end
end, {})

vim.api.nvim_create_user_command('WindowHello', function() M.cmd_to_buf { 'echo', 'hello' } end, {})

return M
