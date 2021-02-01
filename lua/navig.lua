-- local dbg = require("debugger")
-- dbg.auto_where = 2
local _context = require'context'
local context
local api

local function init_context()
  context = _context.context()
  api     = context.api
end

local function get_lnb_from_line()
  local fn = string.gsub(context.line, ":? .*", "")
  if string.match(fn, ":%d+$") then
    local lnbstr = string.gsub(fn, "^[^:]*:", "")
    if string.match(lnbstr, ":%d+$") then
      lnbstr = string.gsub(lnbstr, ":%d+$", "")
    end
    return lnbstr + 0
  else
    return 1
  end
  
end

local function to_file()
  init_context()
  local lnb = get_lnb_from_line()
  api.normal('gf' .. lnb .. 'Gzz') 
end
return {
  to_file = to_file
}

