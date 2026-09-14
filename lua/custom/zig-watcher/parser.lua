local M = {}

function M.parse_diagnostics(lines)
  local items = {}
  for _, line in ipairs(lines) do
    if not line:match("^%s") and not line:match("^referenced by:") then
      local filename, line_number, column, severity, message =
        line:match("^(.-):(%d+):(%d+): (%a+): (.*)$")
      if filename then
        table.insert(items, {
          filename = filename,
          lnum = tonumber(line_number),
          col = tonumber(column),
          type = severity:sub(1, 1):upper(),
          text = message,
        })
      end
    end
  end
  return items
end




local namespace = vim.api.nvim_create_namespace("zig_watcher")

M.severity_groups = {
  E = "DiagnosticError",
  W = "DiagnosticWarn",
  I = "DiagnosticInfo",
  N = "DiagnosticHint",
}

function M.render_items(buffer_number, items)
  local lines = {}
  local marks = {}

  for index, item in ipairs(items) do
    local location = string.format("%s:%d:%d",
      vim.fn.fnamemodify(item.filename, ":."), item.lnum, item.col)
    local row = index - 1   -- extmark rows are 0-indexed

    lines[index] = location .. "  " .. item.text
    marks[#marks + 1] = { row = row, col = 0, end_col = #location,
                          group = "Directory" }
    marks[#marks + 1] = { row = row, col = #location + 2,
                          end_col = #lines[index],
                          group = M.severity_groups[item.type] or "Normal" }
  end

  if #lines == 0 then
    lines = { "no diagnostics" }
  end

  vim.bo[buffer_number].modifiable = true
  vim.api.nvim_buf_set_lines(buffer_number, 0, -1, false, lines)
  vim.bo[buffer_number].modifiable = false

  vim.api.nvim_buf_clear_namespace(buffer_number, namespace, 0, -1)
  for _, mark in ipairs(marks) do
    vim.api.nvim_buf_set_extmark(buffer_number, namespace, mark.row, mark.col, {
      end_col = mark.end_col,
      hl_group = mark.group,
    })
  end
end

return M
