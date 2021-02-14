-- local dbg = require("debugger")
-- dbg.auto_where = 2
local api = vim.api
local lines

local function call_function(name, ...)
  -- dbg()
  return api.nvim_call_function(name, {...})
end

local function get_current_line()
  return api.nvim_get_current_line()
end

local function get_cursor()
  return api.nvim_win_get_cursor(0)
end

local function get_mark(mark)
  return api.nvim_buf_get_mark(0, mark)
end

local function get_selected_lines()
  local fl = get_mark('<')[1]
  local ll = get_mark('>')[1]
  return fl, ll, lines(fl, ll)
end

function lines(f, l)
  return api.nvim_buf_get_lines(0, f - 1, l, false)
end

local function normalise_cursor(lc, c)
  if type(lc) == "table" then
    return lc
  else
    return {lc, c or 999}
  end
end

local function set_current_line(data)
  local lnb = get_cursor()[1]
  api.nvim_buf_set_lines(0, lnb - 1, lnb, false, {data})
end

local function get_selected_part()
  local fc = get_mark('<')[2]
  local lc = get_mark('>')[2]
  local line = api.nvim_get_current_line()
  local selected = string.sub(line, fc + 1, lc + 1)
  return {selection=selected, begcol=fc, endcol=lc, line=line}
end

local function set_selected_part(new, sel)
  if not new then return end
  local sel = sel or get_selected_part()
  local new_line = string.sub(sel.line, 1, sel.begcol) .. new .. string.sub(sel.line, sel.endcol + 2)
  set_current_line(new_line)
end

return {
  api = api,
  buffer = function() return api.nvim_buf_get_lines(0, 0, -1, false) end,
  call_function = call_function,
  command = function(cmd) api.nvim_command(cmd) end,
  cursor = get_cursor,
  delete_lines = function(f, l) api.nvim_buf_set_lines(0, f - 1, l, false, {}) end,
  eval = function(str) return api.nvim_eval(str) end,
  get_mark = get_mark,
  get_reg  = function(reg) return api.nvim_eval('@' .. reg) end,
  get_selected_lines = get_selected_lines,
  get_selected_part = get_selected_part,
  line = get_current_line,
  line_at = function(idx) return api.nvim_buf_get_lines(0, idx - 1, idx, false)[1] end,
  line_count = function() return api.nvim_buf_line_count(0) end,
  lines = lines,
  lnb  = function() return api.nvim_call_function('line', {'.'}) end,
  normal = function(normal_cmd) return api.nvim_command('normal ' .. normal_cmd) end,
  option = function(name) return api.nvim_buf_get_option(0, name) end,
  p = function(val) print(vim.inspect(val)) end,
  set_current_line = set_current_line,
  set_cursor = function(l, c) api.nvim_win_set_cursor(0, normalise_cursor(l, c)) end,
  set_lines = function(f, l, data) api.nvim_buf_set_lines(0, f - 1, l, false, data) end,
  set_selected_part = set_selected_part,
  system = function(cmd) call_function("system", cmd) end,
  var = function(name) return api.nvim_get_var(name) end,
}
