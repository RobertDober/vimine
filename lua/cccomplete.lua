-- local dbg = require("debugger")
-- dbg.auto_where = 2
local context = require'context'.context
local complete = require'cccomplete.general'.complete

local function cccomplete(_lnb1, _lnb2)
  local ctxt  = context()
  local api = ctxt.api
  local result = complete(ctxt)
  if result then
    api.set_lines(ctxt.lnb, ctxt.lnb, result.lines)
    api.set_cursor(ctxt.lnb+result.offset, result.col)
  end
end

return {
  complete = cccomplete,
}
