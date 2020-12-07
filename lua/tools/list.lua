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

return { 
  append = append,
  readonly = readonly,
  slice  = slice
}
