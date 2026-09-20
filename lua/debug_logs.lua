-- NOTE: the following lines can be used to debug lua code if necessary. Leave false otherwise as
-- it slows down nvim
local M = {}

function M.setup(debug_mode)
  if not debug_mode then return end

  vim.lsp.log.set_level(vim.log.levels.DEBUG)

  local watchdog_threshold_nanoseconds = 5e9 -- 5 s of no event-loop turn
  local watchdog_hook_interval = 1e6 -- check every 1M VM instructions
  local watchdog_log_path = vim.fn.stdpath 'log' .. '/watchdog.log'

  local last_loop_tick_nanoseconds = vim.uv.hrtime()
  local report_count = 0
  local max_reports = 5

  local prepare_handle = vim.uv.new_prepare()
  prepare_handle:start(function()
    last_loop_tick_nanoseconds = vim.uv.hrtime()
    report_count = 0
  end)

  local function write_watchdog_report(traceback_text)
    local log_file = io.open(watchdog_log_path, 'a')
    if not log_file then return end
    log_file:write(
      ('=== %s | stalled %.1f s ===\n%s\n\n'):format(os.date '%Y-%m-%d %H:%M:%S', (vim.uv.hrtime() - last_loop_tick_nanoseconds) / 1e9, traceback_text)
    )
    log_file:close()
  end

  debug.sethook(function()
    if report_count >= max_reports then return end
    if vim.uv.hrtime() - last_loop_tick_nanoseconds < watchdog_threshold_nanoseconds then return end
    report_count = report_count + 1
    write_watchdog_report(debug.traceback('Lua blocked the event loop', 2))
  end, '', watchdog_hook_interval)
end
return M
