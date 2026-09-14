local M = {}
M.builder = require 'custom.zig-watcher.zig-build'

M.print_root = M.builder.print_root
M.build_project = M.builder.build_project
M.run_project = M.builder.run_project
M.test_project = M.builder.test_project
M.build_file = M.builder.build_file
M.run_file = M.builder.run_file
M.test_file = M.builder.test_file
M.test_single = M.builder.test_single


function M.setup(opts)
  opts = opts or {}

  -- build and run commands
  vim.keymap.set('n', '<leader>bpr', M.print_root, { desc = '[P]rint the [R]oot of the [P]roject' })
  vim.keymap.set('n', '<leader>bbp', M.build_project, { desc = '[B]uild the [P]roject' })
  vim.keymap.set('n', '<leader>brp', M.run_project, { desc = '[R]un the [P]roject' })
  vim.keymap.set('n', '<leader>btp', M.test_project, { desc = '[T]est the [P]roject' })

  -- commands for single files
  vim.keymap.set('n', '<leader>bbf', M.build_file, { desc = '[B]uild the [F]ile' })
  vim.keymap.set('n', '<leader>brf', M.run_file, { desc = '[R]un the [P]roject' })
  vim.keymap.set('n', '<leader>btf', M.test_file, { desc = '[T]est the [P]roject' })
  vim.keymap.set('n', '<leader>btt', M.test_single, { desc = '[T]est the [T]est under the current cursor' })
end

  

return M
