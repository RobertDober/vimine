-- local dbg = require("debugger")
-- dbg.auto_where = 2
--
local split = require 'tools.string'.split
local map   = require 'tools.fn'.map

local function capitalize(str)
    return string.upper(string.sub(str, 1, 1)) .. string.sub(str, 2)
end

local function camelize(name)
  local parts = split(name, "_")
  return table.concat(map(parts, capitalize))
end

  
local function camelize_path(path)
  local path = string.gsub(path, "[.][^.]*$", "")
  local segments = split(path, "/")
  return table.concat(map(segments, camelize), ".") 
end

return {
  camelize      = camelize,
  camelize_path = camelize_path,
}
