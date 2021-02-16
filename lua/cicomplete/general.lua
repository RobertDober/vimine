-- local dbg = require("debugger")
-- dbg.auto_where = 2

local function squash_spaces(ctxt)
  local lhs = string.gsub(ctxt.prefix, '%s+$', '')
  local rhs = string.gsub(ctxt.suffix, '^%s+', '')
  return lhs .. ctxt.char .. rhs
end

local chars = {
  [' '] = squash_spaces,
}

return function(ctxt)
  -- falling through to NOP
  local completer = chars[ctxt.char]
  if completer then return completer(ctxt) end
  return ctxt.prefix .. ctxt.char .. ctxt.suffix
end

