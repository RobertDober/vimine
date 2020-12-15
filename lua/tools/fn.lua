-- local dbg = require("debugger")
-- dbg.auto_where = 2

local append = require"tools.list".append

local function curry(fn, ...)
  local def_time_params = {...}
  return function(...) 
    local call_time_params = {...}
    local total_params = append(def_time_params, call_time_params)
    return fn(table.unpack(total_params))
  end
end

local function foldl(list, fn, initial)
  local init_idx = 1
  local acc = initial
  if not acc then
    if #list == 0 then error("must not fold an empty list without an initial value") end
    init_idx = 2
    acc = list[1]
  end
  for idx = init_idx, #list do
    acc = fn(acc, list[idx])
  end
  return acc
end

-- OMG for side effects
local function each(list, fn)
  foldl(list, function(_, ele) fn(ele) end, true)
end

local function map(list, fn)
  local append = function(list, ele)
    table.insert(list, fn(ele))
    return list
  end
  return foldl(list, append, {})
end
local function range(low, high, step)
  local step = step or 1
  local result = {}
  for i = low, high, step do
    table.insert(result, i)
  end
  return result
end

return {
  curry = curry,
  each = each,
  foldl = foldl,
  map = map,
  range = range,
}
