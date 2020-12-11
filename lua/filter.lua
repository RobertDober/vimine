local api = require("vimapi")

local function filter_with(lnb1, lnb2, filter)
  local lnb1 = lnb1 - 1
  local lines  = api.buf_get_lines(0, lnb1, lnb2, false) -- 0 → current buffer, false → not strict indexing
  local result = filter(lines)
  api.buf_set_lines(0, lnb1, lnb2, false, result)
end

return {
  filter_with = filter_with
}
