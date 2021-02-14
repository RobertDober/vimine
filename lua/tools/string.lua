-- local dbg = require("debugger")
-- dbg.auto_where = 2
local map = require 'tools.fn'.map
local find_match = require 'tools/fn'.find_match
local _replacer

local function chunk(str, spos, epos)
  local str   = str
  local startpos = spos or 1
  local endpos   = epos or #str
  return {
    chunk  = function() return string.sub(str, startpos, endpos) end,
    delete = function() return _replacer(str, startpos, endpos)("") end,
    endpos = function() return endpos end,
    prefix = function() return string.sub(str, 1, startpos - 1) end,
    replace = _replacer(str, startpos, endpos),
    startpos = function() return startpos end,
    string = function() return str end,
    suffix = function() return string.sub(str, endpos + 1, -1) end,
    to_s   = function(self) return {
      str = str, spos = startpos, epos = endpos, chunk = self.chunk() 
    } end
  }
end

_replacer = function(str, startpos, endpos)
  return function(new)
    local prefix = string.sub(str, 1, startpos - 1)
    local suffix = string.sub(str, endpos + 1, -1) 
    local newstr = prefix .. new .. suffix
    return chunk(newstr, startpos, startpos + #new - 1)
  end
end

local function match_at(str, pos, pattern)
  local pattern = pattern or "[%w_]+"
  local str     = str
  local pos     = pos
  local spos    = pos
  local epos    = pos - 1
  -- dbg()
  -- N.B. pfx and sfx overlap by one grapheme therefor the either both match or match not
  local pfx     = string.sub(str, 1, pos)
  local sfx     = string.sub(str, pos, -1)
  local pm      = string.match(pfx, pattern .. "$")
  local sm      = string.match(sfx, "^" .. pattern)
  if pm then
    return chunk(str, spos + 1 - #pm, epos + #sm)
  else
    return chunk(str, pos, pos - 1)
  end 
end

local function split(inputstr, sep)
  if sep == "" then
    return map(inputstr)
  end
  if sep == nil then
    sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end


local matching_pairs = {
  ["%w"] = "%W",
  ["%s"] = "%S"
}

local function find_matched(str, start, incr, pattern)
  local idx = start
  local len = #str
  while idx > 0 and idx <= len do
    if string.match(string.sub(str, idx, idx), pattern) then return idx end
    idx = idx + incr
  end
  -- print("idx "..idx)
  return idx
end

local function split_at_col(line, col)
  local col = col + 1
  local char = string.sub(line, col, col)
  local matched = find_match(matching_pairs, char)
  if not matched then return "", line, "" end
  local lpos = find_matched(line, col-1, -1, matched)
  local rpos = find_matched(line, col+1, 1, matched)
  -- print("lpos"..lpos)
  -- print("rpos"..rpos)
  return string.sub(line, 1, lpos),
    string.sub(line, lpos+1, rpos-1),
    string.sub(line, rpos, #line)
end

return {
  chunk = chunk,
  match_at = match_at,
  split = split,
  split_at_col = split_at_col,
}
