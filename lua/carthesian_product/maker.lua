local map = require'tools.fn'.map
local split = require'tools.string'.split

local function combine(result, new_values, joiner)
  local t = {}
  for _, r in ipairs(result) do
    for _, n in ipairs(new_values) do
      table.insert(t, r .. joiner .. n)
    end
  end
  return t
end
local function make(lines, joiner)
  local verbs = map(lines, split)
  local result = table.remove(verbs, 1)
  for _, next_values in ipairs(verbs) do
    result = combine(result, next_values, joiner)
  end
  return result
end
return {
  make = make
}
