-- local dbg = require("debugger")
-- dbg.auto_where = 2
local api             = require'nvimapi'
local cvcomplete = require'cvcomplete/cvcompleter'

local function complete()
  local sel = api.get_selected_part()
  local completion = cvcomplete(sel.selection, api.option('ft'))
  api.set_selected_part(completion, sel)
end
return {
  complete = complete,
}
