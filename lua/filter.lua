local api = require("nvimapi")

local function filter_with(lnb1, lnb2, filter)
  local lines  = api.lines(lnb1, lnb2)
  local result = filter(lines)
  api.set_lines(lnb1, lnb2, result)
end

return {
  filter_with = filter_with
}
