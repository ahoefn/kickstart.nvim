-- Here is a more advanced configuration example that passes options to `gitsigns.nvim`
--
-- See `:help gitsigns` to understand what each configuration key does.
-- Adds git related signs to the gutter, as well as utilities for managing changes
vim.pack.add { Gh 'lewis6991/gitsigns.nvim' }
local gitsigns = require 'gitsigns'
gitsigns.setup {
  signs = {
    add = { text = '+' }, ---@diagnostic disable-line: missing-fields
    change = { text = '~' }, ---@diagnostic disable-line: missing-fields
    delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
    topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
    changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
  },
  -- gitsigns.nvim's recommended keymaps:
  on_attach = function(bufnr)
    -- Navigation
    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, { desc = 'Jump to next git [c]hange', buf = bufnr })

    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, { desc = 'Jump to previous git [c]hange', buf = bufnr })

    -- Visual mode actions
    vim.keymap.set('v', '<leader>gs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = '[G]it [s]tage hunk', buf = bufnr })
    vim.keymap.set('v', '<leader>gr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = '[G]it [r]eset hunk', buf = bufnr })
    -- Normal mode actions
    vim.keymap.set('n', '<leader>gs', gitsigns.stage_hunk, { desc = '[G]it [s]tage hunk', buf = bufnr })
    vim.keymap.set('n', '<leader>gr', gitsigns.reset_hunk, { desc = '[G]it [r]eset hunk', buf = bufnr })
    vim.keymap.set('n', '<leader>gS', gitsigns.stage_buffer, { desc = '[G]it [S]tage buffer', buf = bufnr })
    vim.keymap.set('n', '<leader>gR', gitsigns.reset_buffer, { desc = '[G]it [R]eset buffer', buf = bufnr })
    vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk, { desc = '[G]it [p]review hunk', buf = bufnr })
    vim.keymap.set('n', '<leader>gi', gitsigns.preview_hunk_inline, { desc = '[G]it preview hunk [i]nline', buf = bufnr })
    vim.keymap.set('n', '<leader>gb', function() gitsigns.blame_line { full = true } end, { desc = '[G]it [b]lame line', buf = bufnr })
    vim.keymap.set('n', '<leader>gd', gitsigns.diffthis, { desc = '[G]it [d]iff against index', buf = bufnr })
    vim.keymap.set('n', '<leader>gD', function() gitsigns.diffthis '~' end, { desc = '[G]it [D]iff against last commit', buf = bufnr })
    vim.keymap.set('n', '<leader>gQ', function() gitsigns.setqflist 'all' end, { desc = '[G]it hunk [Q]uickfix list (all files in repo)', buf = bufnr })
    vim.keymap.set('n', '<leader>gq', gitsigns.setqflist, { desc = '[G]it hunk [q]uickfix list (all changes in this file)', buf = bufnr })
    -- Toggles
    vim.keymap.set('n', '<leader>tob', gitsigns.toggle_current_line_blame, { desc = '[To]ggle [G]it show [b]lame line', buf = bufnr })
    vim.keymap.set('n', '<leader>tow', gitsigns.toggle_word_diff, { desc = '[To]ggle [G]it intra-line [w]ord diff', buf = bufnr })
    -- Text object
    vim.keymap.set({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'text object [i]nside [h]unk', buf = bufnr })
  end,
}

