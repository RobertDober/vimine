local access_by_match = require'tools'().access_by_match
local api             = require'vimapi'
local _context        = require'context'
local context

local function get_selection(cols)
  return context.line:sub(cols.begcol+1, cols.endcol+1)
end

local function ruby_sym_to_sq(selection)
  return "'" .. selection:sub(2) .. "'"
end
local function ruby_sq_to_dq(selection)
  return '"' .. selection:sub(2, #selection - 1) .. '"'
end
local function ruby_dq_to_sym(selection,col)
  return ":" .. selection:sub(2, #selection - 1)
end
local ruby_toggles = {
  ["^:[%a_][%a%d_]+$"] = ruby_sym_to_sq,
  ["'[%a_][%a%d_]+'$"] = ruby_sq_to_dq,
  ['"[%a_][%a%d_]+"$'] = ruby_dq_to_sym,
}
local function ruby_toggler(cols)
  local selected = get_selection(cols)
  local kind = access_by_match(selected, ruby_toggles)
  if not kind then return end
  local new_value = kind(selected)
  local new_line = context.line:sub(1, cols.begcol) .. new_value .. context.line:sub(cols.endcol+2)
  api.set_current_line(new_line)
  api.normal_command('viw')
end

local lua_toggles = {
}
lua_toggles["false"] = "true"
lua_toggles["true"] = "false"
local function lua_toggler(cols)
  local selected = get_selection(cols)
  local new_value = lua_toggles[selected] or selected
  local new = context.line:sub(1, cols.begcol) .. new_value .. context.line:sub(cols.endcol+2)
  api.set_current_line(new)
  api.normal_command('viw')
end
local togglers = {
  lua = lua_toggler,
  ruby = ruby_toggler
}

local function cxcomplete()
  context = _context.context()
  local toggler = togglers[context.ft]
  if not toggler then return end
  
  local mark = api.get_mark("<")
  local begcol = mark[2]
  local endcol = api.get_mark(">")[2]

  new = toggler{begcol=begcol, endcol=endcol}

end

return {
  complete = cxcomplete,
}
