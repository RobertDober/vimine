-- local dbg = require("debugger")
-- dbg.auto_where = 2
local range = require'tools.range'
local slice

local function append(list1, list2, fn)
  local result = {}
  if fn then
    for _, val in ipairs(list1) do
      table.insert(result, fn(val))
    end
    for _, val in ipairs(list2) do
      table.insert(result, fn(val))
    end
  else
    for _, val in ipairs(list1) do
      table.insert(result, val)
    end
    for _, val in ipairs(list2) do
      table.insert(result, val)
    end
  end
  return result
end

local function concat(...)
  local result = {}
  for _, table in ipairs({...}) do
    result = append(result, table)
  end
  return result
end

local function listmod(n, s)
  local r = n % s
  if r == 0 then
    return s
  else
    return r
  end
end

local function partition(list, spos, epos)
  local lhs = slice(list, 1, spos - 1)
  local mhs = slice(list, spos, epos)
  local rhs = slice(list, math.max(epos, spos - 1) + 1)

  return lhs, mhs, rhs
end

local function readonly(t, msg)
  local proxy = {}
  local mt = {
  __index = t,
  __newindex = function (t,k,v)
    error(msg or "attempt to update a read-only table", 2)
  end
  }
  setmetatable(proxy, mt)
  return proxy
end

slice = function(list, startpos, endpos, fn)
  local endpos = endpos or #list
  if endpos < 0 then
    endpos = #list + 1 + endpos
  end
  if startpos < 0 then
    startpos = #list + 1 + startpos
  end
  local rng = range(startpos, endpos):intersect(startpos, #list)
  local result = {}
  if fn then
    for idx in rng:iter() do
      table.insert(result, fn(list[idx]))
    end
  else
    for idx in rng:iter() do
      table.insert(result, list[idx])
    end
  end
  return result
end

local function rotate_left(list, by)
  local by = by or 1
  local t = {}
  local s = #list
  for idx, value in ipairs(list) do
    t[listmod(idx - by, s)] = value
  end
  return t
end

local function rotate_right(list, by)
  local by = by or 1
  local t = {}
  local s = #list
  for idx, value in ipairs(list) do
    t[listmod(idx + by, s)] = value
  end
  return t
end

local function replace(source, idx1, idx2, with)
  local lhs, middle, rhs = partition(source, idx1, idx2)
  local result = concat(lhs, with, rhs)
  return result
end

local function reverse(list)
  
end

local function tail_from(list, fun, include)
  local include = include or false
  local result = {}
  for i = #list, 1, -1 do
    if fun(list[i]) then
      if include then
        table.insert(result, 1, list[i])
      end
      return result
    end
    table.insert(result, 1, list[i])
  end
  return result
end
return { 
  append = append,
  concat = concat,
  partition = partition,
  readonly = readonly,
  replace = replace,
  reverse = reverse,
  rotate_left = rotate_left, 
  rotate_right = rotate_right,
  slice  = slice,
  tail_from  = tail_from,
}
