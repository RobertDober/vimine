-- local dbg = require("debugger")
-- dbg.auto_where = 2
local append = require"tools.list".append

local free = {}
local function combine_params(dtp, ctp)
  local t = {}
  for _, value in ipairs(dtp) do
    if value == free then
      table.insert(t, table.remove(ctp, 1))
    else
      table.insert(t, value)
    end
  end
  return append(t, ctp)
end

local function merge_onto(target, src)
  for k, v in pairs(src) do
    target[k] = v
  end
end

local function merge(...)
  local result = {}
  local tables = {...}
  for _, table in ipairs(tables) do
    merge_onto(result, table)
  end
  return result
end

local function curry(fn, ...)
  local def_time_params = {...}
  return function(...) 
    local call_time_params = {...}
    local total_params = append(def_time_params, call_time_params)
    return fn(table.unpack(total_params))
  end
end

local function curry_at(fn, ...)
  local def_time_params = {...}
  return function(...)
    local call_time_params = {...}
    local total_params = combine_params(def_time_params, call_time_params)
    return fn(table.unpack(total_params))
  end
end

local function curry_kwd(fn, ctkwds)
  local ctkwds = ctkwds
  return function(rtkwds)
    local total_kwds=merge(ctkwds, rtkwds)
    return fn(total_kwds)
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
  curry_at = curry_at,
  curry_kwd = curry_kwd,
  each = each,
  free = free,
  foldl = foldl,
  map = map,
  merge = merge,
  range = range,
}
