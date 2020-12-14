-- keep usage of vim api in a minimal scope, this file only
local rotate_around = require'rotate_around.maker'.rotate_around
local context = require'context'.context
local api = require'vimapi'
local map = require'tools.fn'.map

local function make(lnb1, lnb2)
  local ctxt = context("vimine_rotate_around_sep")
  local col  = ctxt.col
  local sep  = ctxt.vimine_rotate_around_sep
  -- print(vim.inspect(ctxt))
  local lines = api.buf_get_lines(0, lnb1-1, lnb2, false)
  local result = map(lines, function(line) return rotate_around(col, sep, line) end)

  --   api.buf_set_lines(0, ctxt.lnb-1, ctxt.lnb, false, {result}) -- false → not strict indexing
  api.buf_set_lines(0, lnb1-1, lnb2, false, result) -- false → not strict indexing
end

return {
  rotate_around = make,
}
