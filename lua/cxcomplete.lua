-- local dbg = require("debugger")
-- dbg.auto_where = 2


local find_match = require'tools.fn'.find_match
local api             = require'nvimapi'
local _context        = require'context'
local context

local function get_selection(cols)
  return context.line:sub(cols.begcol+1, cols.endcol+1)
end

local function replace_selection(new_value, cols)
  local new_line = context.line:sub(1, cols.begcol) .. new_value .. context.line:sub(cols.endcol+2)
  api.set_current_line(new_line)
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
  ["^'[%a_][%a%d_]+'$"] = ruby_sq_to_dq,
  ['^"[%a_][%a%d_]+"$'] = ruby_dq_to_sym,
}
local function ruby_toggler(cols)
  local selected = get_selection(cols)
  local kind = find_match(ruby_toggles, selected)
  if not kind then return end
  local new_value = kind(selected)
  return new_value
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
  api.normal('viw')
end
local togglers = {
  lua = lua_toggler,
  ruby = ruby_toggler
}
local default_replacements = {
  ['->'] = '→',
  ['=>'] = '⇒',
  ['<-'] = '←',
  ['<='] = '⇐',
  ['--'] = '↔',
  ['=='] = '⇔',
  ['??'] = '¿',
  ['!!'] = '¡',
  ['copyright'] = '©',
  ['not'] = '¬',
  ['cross'] = '×',
  ['...'] = '…',
  ['tel'] = '☏',
  ['ballot'] = '☐',
  ['ballot_checked'] = '☑',
  ['ballot_failed'] = '☒',
  ['ok'] = '✓',
  ['failed'] = '×',
  ['error'] = '×',
  ['check'] = '✓',
  ['check_heavy'] = '✔',
  ['cross_heavy'] = '✖',
  ['x'] = '✗',
  ['x_heavy'] = '✘',
  [''] = '',
  ['x_red'] = '❌',
  ['white_check'] = '❎',
  ['!_red'] = '❗',
  -- [''] = '',
  -- [''] = '',
  -- [''] = '',
  -- [''] = '',
  -- [''] = '',
  -- [''] = '',
}
local function default_complete()
  local line   = context.line
  local suffix = string.gsub(line, ".* ", "")
  local replacement = default_replacements[suffix]
  if not replacement then return end
  local ll = #line
  local sl = #suffix
  context.set_current_line(string.sub(context.line, 0, ll - sl) .. replacement)
end

local function cxcomplete()
  context = _context.context()
  local toggler = togglers[context.ft]
  if not toggler then return default_complete() end
  
  local mark = api.get_mark("<")
  local begcol = mark[2]
  local endcol = api.get_mark(">")[2]

  new = toggler{begcol=begcol, endcol=endcol}
  if new then
    replace_selection(new, {begcol=begcol, endcol=endcol})
    api.normal('gv')
    return
  end

  return default_complete()
end

return {
  complete = cxcomplete,
}
