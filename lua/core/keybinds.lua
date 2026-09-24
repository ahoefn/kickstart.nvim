-- MY custom keybinds
vim.keymap.set('i', 'kj', '<Esc>', { silent = true })

-- If you want it to work globally in Telescope insert/normal prompts:
vim.keymap.set('i', '<kEnter>', '<CR>', { silent = true })
vim.keymap.set('n', '<kEnter>', '<CR>', { silent = true })

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>x', function()
  vim.cmd.write()
  vim.cmd.source '%'
end, { desc = 'Save and e[X]ecute current file.' })

vim.keymap.set('n', '<leader>ql', vim.diagnostic.setloclist, { desc = 'Open [Q]uick diagnostic [L]ocation list' })
vim.keymap.set('n', '<leader>qq', function()
  local winid = vim.fn.getqflist({ winid = 0 }).winid
  if winid ~= 0 then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end, { desc = 'Toggle [Q]uick diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>qcl', function() vim.fn.setloclist(0, {}) end, { desc = '[C]lear [L]ocation list' })
vim.keymap.set('n', '<leader>qcq', function() vim.fn.setqflist {} end, { desc = '[C]lear [Q]uickfix list' })

-- note: this won't work in all terminal emulators/tmux/etc. try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<leader>wh', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader>wl', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader>wj', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader>wk', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- splitting and closing shortcuts
vim.keymap.set('n', '<leader>ws', ':split<CR>', { desc = '[S]plit along the horizontal axis' })
vim.keymap.set('n', '<leader>wv', ':vsplit<CR>', { desc = 'Split along the [v]ertical axis' })
vim.keymap.set('n', '<leader>wq', ':close<CR>', { desc = '[Q]uit active window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- tabs
vim.keymap.set('n', '<leader>wtn', ':tabnew<CR>', { desc = '[T]ab - [N]ew' })
vim.keymap.set('n', '<leader>wtq', ':tabclose<CR>', { desc = '[T]ab - [Q]uit' })
vim.keymap.set('n', '<leader>wtl', ':tabnext<CR>', { desc = '[T]ab - [N]ext' })
vim.keymap.set('n', '<leader>wth', ':tabprevious<CR>', { desc = '[T]ab - [P]revious' })
vim.keymap.set('n', '<leader>wtj', ':tabfirst<CR>', { desc = '[T]ab - First' })
vim.keymap.set('n', '<leader>wtk', ':tabclose<CR>', { desc = '[T]ab - Last' })

-- Oil:
vim.keymap.set('n', '<leader>e', ':Oil<CR>', { desc = '[E]xpore files from current buffer.' })

-- Useful plugin to show you pending keybinds.
vim.pack.add { Gh 'folke/which-key.nvim' }
require('which-key').setup {
  -- Delay between pressing a key and opening which-key (milliseconds)
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },
  -- Document existing key chains
  spec = {
    { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
    { '<leader>t', group = '[T]abs', mode = { 'n', 'v' } },
    { '<leader>b', group = '[B]uild commands', mode = { 'n', 'v' } },
    { '<leader>w', group = '[W]indow', mode = { 'n', 'v' } },
    { '<leader>g', group = '[G]it', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
    { '<leader>q', group = 'Open [Q]uickfix lists', mode = { 'n', 'v' } },
    { 'gr', group = 'LSP Actions', mode = { 'n' } },
    { '<leader>a', group = '[A]ctions', mode = { 'n', 'v' } },
    { '<leader>h', group = '[H]arpoon', mode = { 'n' } },
  },
}

-- -- FIXME: temporrary reload command
--
-- vim.keymap.set('n', '<leader>r', function()
--   for module_name in pairs(package.loaded) do
--     if module_name:match '^custom%.zig%-watcher' then package.loaded[module_name] = nil end
--   end
--   require('custom.zig-watcher').setup()
-- end)
