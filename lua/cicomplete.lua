-- local dbg = require("debugger")
-- dbg.auto_where = 2
local context = require'context'.context
local complete = require'cicomplete.general'

local function cicomplete()
  local ctxt  = context()
  local new_line = complete(ctxt)
  api.set_current_line(new_line)
end

return {
  complete = cicomplete,
}
