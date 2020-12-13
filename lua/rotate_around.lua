-- keep usage of vim api in a minimal scope, this file only
local rotate_around = require'rotate_around.maker'.rotate_around
local api = require'vimapi'

local function make(lnb1, lnb2)
  -- print("lnbs", lnb1, lnb2)
  local lines  = api.buf_get_lines(0, lnb1-1, lnb2, false) -- 0 → current buffer, false → not strict indexing
  -- print("lines:")
  -- for k, v in pairs(lines) do
  --   print("  "..v)
  -- end
  local result = maker.make(lines, api.get_var("vimine_carthesian_product_joiner"))
  -- print("result lines:")
  -- for k, v in pairs(result.lines) do
  --   print("  "..v)
  -- end

  api.buf_set_lines(0, lnb1-1, lnb2-1, false, result) -- false → not strict indexing
end

return {
  make = make,
}
