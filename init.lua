-- Set this for logging which functino we are in 
local debug_mode  = true
require'debug_logs'.setup(debug_mode)

if vim.fn.has("win32") == 1 then

-- FIXME: this is some hacky windows only fix -> proper fix needs to be 
  -- done at some point
  require 'windows_init'
end

require 'theme'

require 'core.options'
require 'core.keybinds'


require 'kickstart.plugins.debug'

require 'plugins.mini'
require 'plugins.telescope'
require 'plugins.conform'
require 'plugins.treesitter'


require 'lsp'
require 'autocomplete'
-- require 'plugins.dap'
require 'plugins.neotest'
require 'plugins.oil'
require 'plugins.gitsigns'



--
-- My own custom plugins
-- require 'custom.zig-watcher'.setup()

-- ============================================================
-- SECTION 10: OPTIONAL EXAMPLES / NEXT STEPS
-- kickstart.plugins.* examples
-- ============================================================
do
  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug'
  -- require 'kickstart.plugins.indent_line'
  -- require 'kickstart.plugins.lint'
  -- require 'kickstart.plugins.autopairs'
  -- require 'kickstart.plugins.neo-tree'

  -- NOTE: You can add your own plugins, configuration, etc. in `lua/custom/plugins/*.lua`.
  --
  -- For independent modules, uncomment the convenience loader:
  -- require 'custom.plugins'
  --
  -- `custom.plugins` automatically loads files from that directory, but their
  -- order is unspecified. If plugins depend on each other, keep them in the same
  -- file and put their `vim.pack.add()` and `setup()` calls in the required order.
  --
  -- If separate modules need a specific order, require them explicitly instead:
  -- require 'custom.plugins.colorscheme'
  -- require 'custom.plugins.ui'
  -- require 'custom.plugins.git'
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
