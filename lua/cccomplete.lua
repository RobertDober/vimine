local context = require'context'.context
local api = require'vimapi'
local complete = require'cccomplete.general'.complete

local function cccomplete(_lnb1, _lnb2)
  local ctxt  = context()
  local result = complete(ctxt)
  if result then
    api.command((ctxt.lnb).."d")
    api.buf_set_lines(0, ctxt.lnb-1, ctxt.lnb-1, false, result.lines) -- false → not strict indexing
    api.win_set_cursor(0, {ctxt.lnb+result.offset, result.col})
  end
end

return {
  complete = cccomplete,
}
