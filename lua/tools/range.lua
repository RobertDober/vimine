-- local dbg = require("debugger")
-- dbg.auto_where = 2

local new

local function _make_range(from, to)
  local t = {}
  for i = from, to do
    table.insert(t, i)
  end
  return t
end

local function _extract_limits(low_or_range, high_or_nil)
  if type(low_or_range) == "table" then
    return low_or_range.low, low_or_range.high
  else
    return low_or_range, (high_or_nil or low_or_range)
  end
end

local function _extend(self, lorrg, hornil)
  local low, high = _extract_limits(lorrg, hornil)
  local new_low = math.min(low, self.low)
  local new_high = math.max(high, self.high)
  return new(new_low, new_high)
end

local function _intersect(self, lorrg, hornil)
  local low, high = _extract_limits(lorrg, hornil)
  local new_low = math.max(low, self.low)
  local new_high = math.min(high, self.high)
  return new(new_low, new_high)
end

local function _iter(self)
  local count = self.low
  local high  = self.high
  return function()
    if count <= high then
      count = count + 1
      return count - 1
    end
  end
end

local function _to_list(self)
  -- dbg()
  if self._list then return self._list end 
  self._list = _make_range(self.low, self.high)
  return self._list
end

new = function(low, high)
  local high = high or low
  return {
    -- data
    low = low,
    high = high,
    _list = nil,
    -- methods
    extend = _extend,
    intersect = _intersect,
    iter = _iter,
    to_list = _to_list,
  }
end
return new
