local M = {}

local window = require 'custom.zig-watcher.window'

local function resolve_project_root()
  local root = vim.fs.root(0, 'build.zig')
  if not root then
    vim.notify('no build.zig found', vim.log.levels.ERROR)
    return
  end

  return root
end

function M.print_root()
  window.open_build_window()
  local cmd = { 'echo', 'Current root path:', resolve_project_root() }
  window.cmd_to_buf(cmd)
end

-- Project level
function M.build_project()
  local project_root = resolve_project_root()
  -- print(project_root)
  window.open_build_window()
  window.cmd_to_buf({ 'zig', 'build' }, { cwd = project_root })
end

function M.run_project()
  local project_root = resolve_project_root()
  -- print(project_root)
  window.open_build_window()
  window.cmd_to_buf({ 'zig', 'build', 'run' }, { cwd = project_root })
end

function M.test_project()
  local project_root = resolve_project_root()
  -- print(project_root)
  window.open_build_window()
  window.cmd_to_buf({ 'zig', 'build', 'test' }, { cwd = project_root })
end

-- File level

function M.build_file(opts)
  opts = opts or { build_output = 'exe' }
  local file_path = vim.api.nvim_buf_get_name(0)
  -- print(project_root)
  window.open_build_window()
  window.cmd_to_buf { 'zig', 'build-' .. opts.build_output, file_path }
end

function M.run_file(opts)
  opts = opts or { build_output = 'exe' }
  local file_path = vim.api.nvim_buf_get_name(0)
  -- print(project_root)
  window.open_build_window()
  window.cmd_to_buf { 'zig', 'run', file_path }
end

function M.test_file(opts)
  opts = opts or { build_output = 'exe' }
  local file_path = vim.api.nvim_buf_get_name(0)
  -- print(project_root)
  window.open_build_window()
  window.cmd_to_buf { 'zig', 'test', file_path }
end
-- test level
local function current_test_name()
  local node = vim.treesitter.get_node()
  while node do
    if node:type() == 'test_declaration' then
      for child in node:iter_children() do
        if child:type() == 'string' then
          local text = vim.treesitter.get_node_text(child, 0)
          return text:sub(2, -2) -- strip the surrounding quotes
        end
      end
      return nil -- an unnamed test
    end
    node = node:parent()
  end
end

function M.test_single()
  local test_name = current_test_name()
  local file_path = vim.api.nvim_buf_get_name(0)

  window.open_build_window()
  window.cmd_to_buf { 'zig', 'test', file_path, '--test-filter', test_name }
end

return M
