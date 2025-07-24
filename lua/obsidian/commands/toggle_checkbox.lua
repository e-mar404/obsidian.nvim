local toggle_checkbox = require("obsidian.api").toggle_checkbox
local util = require "obsidian.util"

---@param data CommandArgs
return function(_, data)
  local start_line, end_line
  local checkboxes

  if data.args == "" then
    checkboxes = Obsidian.opts.checkbox.order
  elseif util.tbl_contains(Obsidian.opts.checkbox.order, data.args) then
    checkboxes = { data.args }
  else
    error(
      "toggle_checkbox: argument passed ("
        .. data.args
        .. ") is not part of the list of checkboxes: "
        .. vim.inspect(Obsidian.opts.checkbox.order)
    )
  end

  start_line = data.line1
  end_line = data.line2

  local buf = vim.api.nvim_get_current_buf()

  for line_nb = start_line, end_line do
    local current_line = vim.api.nvim_buf_get_lines(buf, line_nb - 1, line_nb, false)[1]
    if current_line and current_line:match "%S" then
      toggle_checkbox(checkboxes, line_nb)
    end
  end
end
