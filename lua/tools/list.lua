-- local dbg = require("debugger")
-- -- Consider enabling auto_where to make stepping through code easier to follow.
-- dbg.auto_where = 2

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

local function listmod(n, s)
  local r = n % s
  if r == 0 then
    return s
  else
    return r
  end
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

local function slice(list, startpos, endpos, fn)
  local endpos = endpos or #list
  local result = {}
  if fn then
    for idx = startpos, endpos do
      table.insert(result, fn(list[idx]))
    end
  else
    for idx = startpos, endpos do
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

local function reverse(list)
  
end

return { 
  append = append,
  readonly = readonly,
  reverse = reverse,
  rotate_left = rotate_left, 
  rotate_right = rotate_right,
  slice  = slice,
}
