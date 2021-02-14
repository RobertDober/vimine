-- local dbg = require("debugger")
-- dbg.auto_where = 2

local default_cvcompleter = require'cvcomplete/default_cvcompleter'
local ruby_cvcompleter = require'cvcomplete/ft/ruby_cvcompleter'
local lua_cvcompleter = require'cvcomplete/ft/lua_cvcompleter'

local cvcompleters = {
  lua = lua_cvcompleter,
  ruby = ruby_cvcompleter
}
local function cvcomplete(sel, ft)
  local completion = nil

  local cvcompleter = cvcompleters[ft]
  if cvcompleter then
    completion = cvcompleter(sel)
  end
  if not completion then
    completion = default_cvcompleter(sel)
  end
  return completion
end

return cvcomplete
