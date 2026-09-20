vim.pack.add({
    'https://github.com/stevearc/oil.nvim',
})
require("oil").setup({
  lsp_file_methods = {
    timeout_ms = 30000,
    autosave_changes = "unmodified",
  },
})
