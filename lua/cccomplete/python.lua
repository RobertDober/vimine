-- local dbg = require("debugger")
-- dbg.auto_where = 2
local H = require "cccomplete.helpers"()
local indent = require "cccomplete.helpers"().indent

local all_patterns =
{
}
local function complete(ctxt)
  local completion = H.complete_from_patterns(ctxt, all_patterns)
  if completion then
    return completion
  else
    return H.make_return_object{lines = {ctxt.line, ctxt.line .. "    "}}
  end
end

return {
  complete = complete
}
