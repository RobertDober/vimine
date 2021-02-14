-- local dbg = require("debugger")
-- dbg.auto_where = 2


local find_match = require'tools.fn'.find_match
local api             = require'nvimapi'
local _context        = require'context'
local context

local function lua_cvcompleter(selection)
end

local function ruby_cvcompleter(selection)
local cvcompleters = {
  lua = lua_cvcompleter,
  ruby = ruby_cvcompleter
}
local function cvcomplete()
  local sel = api.get_selected_part()

  local cvcompleter = cvcompleters[context.ft] or default_cvcompleter

  local completion = completer(sel) or default_cvcompleter(sel)

  if completion then
    api.set_current_line(new_line)

  end


  new = cvcompleter{begcol=begcol, endcol=endcol}
  if new then
    replace_selection(new, {begcol=begcol, endcol=endcol})
    api.normal('gv')
    return
  end

  return default_complete()
end

return {
  complete = cvcomplete,
}
