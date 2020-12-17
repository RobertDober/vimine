local H = require'cccomplete.helpers'()
local ctxt

local completers = {
  elixir   = require("cccomplete.elixir")(),
  lua      = require("cccomplete.lua")(),
  markdown = require("cccomplete.markdown")(),
  ruby     = require("cccomplete.ruby")(),
}

local function _insert_datetime()
  local now = ctxt.api.eval('strftime("%F %T", localtime())')
  local nl  = string.gsub(ctxt.line, "%%datetime", now)
  return H.make_return_object{lines = {nl}, offset = 0}
end
local general_patterns = {
  datetime = _insert_datetime,
}
local general_pattern = "%%([%w_]+)$"
local function check_for_general_completer()
  local m = string.match(ctxt.line, general_pattern)
  return general_patterns[m]
end

local function complete(ct)
  ctxt = ct
  local general_completer = check_for_general_completer()

  if general_completer then
    return general_completer()
  end

  local completer = completers[ctxt.ft]
  local result
  if completer then
     return completer.complete(ctxt) 
  end
end

return {
  complete = complete,
}

