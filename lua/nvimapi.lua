-- local dbg = require("debugger")
-- dbg.auto_where = 2
local api = vim.api
local function normalise_cursor(lc, c)
  if type(lc) == "table" then
    return lc
  else
    return {lc, c or 999}
  end
end

local function call_function(name, ...)
  -- dbg()
  return api.nvim_call_function(name, {...})
end

return {
  api = api,
  buffer = function() return api.nvim_buf_get_lines(0, 0, -1, false) end,
  call_function = call_function,
  command = function(cmd) api.nvim_command(cmd) end,
  cursor = function() return api.nvim_win_get_cursor(0) end,
  delete_lines = function(f, l) api.nvim_buf_set_lines(0, f - 1, l, false, {}) end,
  get_mark = function(mark) return api.nvim_buf_get_mark(0, mark) end,
  get_reg  = function(reg) return api.nvim_eval('@' .. reg) end,
  set_cursor = function(l, c) api.nvim_win_set_cursor(0, normalise_cursor(l, c)) end,
  eval = function(str) return api.nvim_eval(str) end,
  line = function() return api.nvim_get_current_line() end,
  line_at = function(idx) return api.nvim_buf_get_lines(0, idx - 1, idx, false)[1] end,
  line_count = function() return api.nvim_buf_line_count(0) end,
  lines = function(f, l) return api.nvim_buf_get_lines(0, f - 1, l, false) end,
  normal = function(normal_cmd) return api.nvim_command('normal ' .. normal_cmd) end,
  set_lines = function(f, l, data) api.nvim_buf_set_lines(0, f - 1, l, false, data) end,
  system = function(cmd) call_function("system", cmd) end,
  option = function(name) return api.nvim_buf_get_option(0, name) end,
  var = function(name) return api.nvim_get_var(name) end,
}
