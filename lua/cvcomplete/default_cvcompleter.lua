-- local dbg = require("debugger")
-- dbg.auto_where = 2

local find_match = require'tools.fn'.find_match
local split = require'tools.string'.split

local function sort_and_join(elements, sep)
  local elements = elements
  table.sort(elements)
  return table.concat(elements, sep)
end

local function switch_and_join(elements, sep)
  return elements[2] .. sep .. elements[1]
end

local function complete_list(sel)
  local elements = split(sel, ', ')
  if not elements then return end
  if #elements == 2 then
    return switch_and_join(elements, ', ')
  elseif #elements > 2 then
    return sort_and_join(elements, ', ')
  end
end
  
return function(sel)
  local result = complete_list(sel)
  if result then return result end
  return result
end
