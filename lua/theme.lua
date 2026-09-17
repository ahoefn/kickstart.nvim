require 'utils'
-- ============================================================
-- SECTION 4: UI / CORE UX PLUGINS
-- guess-indent, gitsigns, which-key, colorscheme, todo-comments, mini modules
-- ============================================================
-- [[ Installing and Configuring Plugins ]]
--
-- To install a plugin simply call `vim.pack.add` with its git url.
-- This will download the default branch of the plugin, which will usually be `main` or `master`
-- You can also have more advanced specs, which we will talk about later.
--
-- For most plugins its not enough to install them, you also need to call their `.setup()` to start them.
--
-- For example, lets say we want to install `guess-indent.nvim` - a plugin for
-- automatically detecting and setting the indentation.
--
-- We first install it from https://github.com/NMAC427/guess-indent.nvim
-- and then call its `setup()` function to start it with default settings.
vim.pack.add { Gh 'NMAC427/guess-indent.nvim' }
require('guess-indent').setup {}

-- [[ Colorscheme ]]
-- You can easily change to a different colorscheme.
-- Change the name of the colorscheme plugin below, and then
-- change the command under that to load whatever the name of that colorscheme is.
--
-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
vim.pack.add { Gh 'folke/tokyonight.nvim' }
---@diagnostic disable-next-line: missing-fields
require('tokyonight').setup {
  styles = {
    comments = { italic = false }, -- Disable italics in comments
  },
  transparent = true, -- Enable this to disable setting the background color
  -- floats = "transparent", -- style for floating windows
  on_highlights = function(highlights, colors)
  highlights.StatusLine = { bg = colors.bg }
  highlights.StatusLineNC = { bg = colors.bg, fg = colors.fg_gutter }
  highlights.MsgArea = { bg = colors.bg }
  end,
}

-- Load the colorscheme here.
-- Like many other themes, this one has different styles, and you could load
-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
vim.cmd.colorscheme 'tokyonight-night'

-- separate highlighting of module imports
-- vim.api.nvim_set_hl(0, '@module.python', { link = '@namespace' })

-- Highlight todo, notes, etc in comments
vim.pack.add { Gh 'folke/todo-comments.nvim' }
require('todo-comments').setup { signs = false }


-- NOTE: Old statusline of kickstart, I replaced it with lualine
--
-- -- Simple and easy statusline.
-- --  You could remove this setup call if you don't like it,
-- --  and try some other statusline plugin
-- local statusline = require 'mini.statusline'
-- -- Set `use_icons` to true if you have a Nerd Font
-- statusline.setup { use_icons = vim.g.have_nerd_font }
--
-- -- You can configure sections in the statusline by overriding their
-- -- default behavior. For example, here we set the section for
-- -- cursor location to LINE:COLUMN
-- ---@diagnostic disable-next-line: duplicate-set-field
-- statusline.section_location = function() return '%2l:%-2v' end
vim.pack.add {
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
}
require('lualine').setup {
  theme = 'tokyonight',
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
}



-- ... and there is more!
--  Check out: https://github.com/nvim-mini/mini.nvim
