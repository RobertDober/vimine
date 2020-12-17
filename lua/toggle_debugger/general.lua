local context = require'context'.context
local supported_file_types = {
  lua = require 'toggle_debugger.lua'.toggle
}

local function toggle_debugger()
  local ctxt = context()
  local toggler = supported_file_types[ctxt.ft]
  if not toggler then return end

  toggler(ctxt)
  ctxt.api.command("write")
end

return {
  toggle_debugger = toggle_debugger,
}
