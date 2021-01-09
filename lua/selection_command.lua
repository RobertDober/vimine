-- local dbg = require("debugger")
-- dbg.auto_where = 2
local C = require'context'
local S = require
local complete = require'selection.completer'.complete

local function execute(...)
  local ctxt  = C.context()
  local api = ctxt.api
  local selection = C.get_selection() 
  local result = complete(selection, ...)
  C.set_selection(result)
  -- if result then
  --   api.set_lines(ctxt.lnb, ctxt.lnb, result.lines)
  --   api.set_cursor(ctxt.lnb+result.offset, result.col)
  -- end
end

return {
  execute = execute
}
