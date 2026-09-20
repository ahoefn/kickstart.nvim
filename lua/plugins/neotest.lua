vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/nvim-neotest/neotest',
  'https://github.com/nvim-neotest/neotest-python',
}

local neotest = require 'neotest'

-- local function project_python()
--   local root = vim.fn.getcwd()
--   local candidates = {
--     root .. '/.venv/Scripts/python.exe',
--     -- root .. '/.venv/bin/python',
--     -- root .. '/venv/Scripts/python.exe',
--     -- root .. '/venv/bin/python',
--   }
--   for _, candidate in ipairs(candidates) do
--     if vim.uv.fs_stat(candidate) then return candidate end
--   end
--   return vim.fs.normalize(vim.fn.exepath 'python')
-- end

local python_root = '.venv/Scripts/python.exe'
---@diagnostic disable-next-line: missing-fields
neotest.setup {
  adapters = {
    require 'neotest-python' {
      runner = 'pytest',
      python = python_root,
      dap = { justMyCode = false },
    },
    require 'neotest-zig' {
      dap = { adpater = 'lldb' },
    },
  },
  -- discovery = {
  --   enabled = true,
  --   concurrent = 1,
  --   filter_dir = function(name, rel_path, root) return name ~= '.venv' and name ~= 'node_modules' and name ~= '.git' and name ~= '__pycache__' end,
  -- },
  discovery = {
    enabled = false,
    concurrent = 1,
  },
}

vim.keymap.set('n', '<leader>tn', function() neotest.run.run() end, { desc = '[T]est [N]earest' })
vim.keymap.set('n', '<leader>tf', function() neotest.run.run(vim.fn.expand '%') end, { desc = '[T]est [F]ile' })
vim.keymap.set('n', '<leader>ts', function() neotest.summary.toggle() end, { desc = '[T]est [S]ummary' })
vim.keymap.set('n', '<leader>to', function() neotest.output.open { enter = true } end, { desc = '[T]est [O]utput' })
vim.keymap.set('n', '<leader>tl', function() neotest.output_panel.toggle() end, { desc = '[T]est [L]og panel' })
---@diagnostic disable-next-line: missing-fields
vim.keymap.set('n', '<leader>td', function() neotest.run.run { strategy = 'dap' } end, { desc = '[T]est [D]ebug nearest' })
vim.keymap.set('n', '<leader>ta', function() neotest.run.run(vim.fs.normalize(vim.fn.getcwd())) end, { desc = '[T]est run [A]ll' })
