vim.pack.add({
    'https://github.com/stevearc/oil.nvim',
})
require("oil").setup({
  lsp_file_methods = {
    timeout_ms = 30000,
    autosave_changes = "unmodified",
  },
})

-- Keymaps:
vim.keymap.set('n', '<leader>e', ':Oil<CR>', { desc = '[E]xpore files from current buffer.' })
