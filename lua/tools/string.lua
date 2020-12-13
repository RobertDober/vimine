local _replacer

local function chunk(str, spos, epos)
  local str   = str
  local startpos = spos or 1
  local endpos   = epos or #str
  return {
    chunk  = function() return string.sub(str, startpos, endpos) end,
    delete = function() return _replacer(str, startpos, endpos)("") end,
    endpos = function() return endpos end,
    replace = _replacer(str, startpos, endpos),
    startpos = function() return startpos end,
    string = function() return str end,
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

local function split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

return {
  chunk = chunk,
  split = split
}
