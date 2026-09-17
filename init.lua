-- FIXME: log levels high for now
vim.lsp.log.set_level(vim.log.levels.DEBUG)

if vim.fn.has("win32") == 1 then
-- FIXME: this is some hacky windows only fix -> proper fix needs to be 
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


-- NOTE: the following lines can be used to debug lua code if necessary. Leave false otherwise as
-- it slows down nvim

local watchdog_threshold_nanoseconds = 5e9   -- 5 s of no event-loop turn
local watchdog_hook_interval         = 1e6   -- check every 1M VM instructions
local watchdog_log_path              = vim.fn.stdpath("log") .. "/watchdog.log"

local last_loop_tick_nanoseconds = vim.uv.hrtime()
local report_count               = 0
local max_reports                = 5

local prepare_handle = vim.uv.new_prepare()
prepare_handle:start(function()
  last_loop_tick_nanoseconds = vim.uv.hrtime()
  report_count = 0
end)

local function write_watchdog_report(traceback_text)
  local log_file = io.open(watchdog_log_path, "a")
  if not log_file then return end
  log_file:write(("=== %s | stalled %.1f s ===\n%s\n\n"):format(
    os.date("%Y-%m-%d %H:%M:%S"),
    (vim.uv.hrtime() - last_loop_tick_nanoseconds) / 1e9,
    traceback_text))
  log_file:close()
end

debug.sethook(function()
  if report_count >= max_reports then return end
  if vim.uv.hrtime() - last_loop_tick_nanoseconds < watchdog_threshold_nanoseconds then
    return
  end
  report_count = report_count + 1
  write_watchdog_report(debug.traceback("Lua blocked the event loop", 2))
end, "", watchdog_hook_interval)


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
