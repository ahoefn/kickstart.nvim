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

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

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
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'Create a new tab' })
vim.keymap.set('n', '<leader>tq', ':tabclose<CR>', { desc = 'Close the current tab' })
vim.keymap.set('n', '<leader>tl', ':tabnext<CR>', { desc = 'Go to the next tab' })
vim.keymap.set('n', '<leader>th', ':tabprevious<CR>', { desc = 'Go to the previous tab' })
vim.keymap.set('n', '<leader>tj', ':tabfirst<CR>', { desc = 'Go to the last tab' })
vim.keymap.set('n', '<leader>tk', ':tabclose<CR>', { desc = 'Go to the first tab' })

-- FIXME: temporrary reload command
vim.keymap.set('n', '<leader>r', function()
  for module_name in pairs(package.loaded) do
    if module_name:match '^custom%.zig%-watcher' then package.loaded[module_name] = nil end
  end
  require('custom.zig-watcher').setup()
end)
