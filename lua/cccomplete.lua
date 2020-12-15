-- keep usage of vim api in a minimal scope, this file only
local context_with_lines = require'context'.context_with_lines
local api = require'vimapi'

local completers = {
  elixir   = require("cccomplete.elixir")(),
  lua      = require("cccomplete.lua")(),
  markdown = require("cccomplete.markdown")(),
  ruby     = require("cccomplete.ruby")(),
}

local function cccomplete(lnb1, lnb2)
  local ctxt  = context_with_lines(lnb1, lnb2)
  local completer = completers[ctxt.ft]
  local result
  if completer then
    result = completer.complete(ctxt) 
    -- print("result lines:")
    -- for k, v in pairs(result.lines) do
    --   print("  "..v)
    -- end

    api.command((ctxt.lnb).."d")
    api.buf_set_lines(0, ctxt.lnb-1, ctxt.lnb-1, false, result.lines) -- false → not strict indexing
    api.win_set_cursor(0, {ctxt.lnb+result.offset, result.col})
  end
end

return {
  complete = cccomplete,
}
