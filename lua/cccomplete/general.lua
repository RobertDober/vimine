local completers = {
  elixir   = require("cccomplete.elixir")(),
  lua      = require("cccomplete.lua")(),
  markdown = require("cccomplete.markdown")(),
  ruby     = require("cccomplete.ruby")(),
}

local function complete(ctxt)
  local completer = completers[ctxt.ft]
  local result
  if completer then
     return completer.complete(ctxt) 
  end
end

return {
  complete = complete,
}

