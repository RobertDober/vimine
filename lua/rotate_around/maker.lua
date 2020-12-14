-- local dbg = require("debugger")
-- dbg.auto_where = 2
local st = require 'tools.string'
local rotate_left = require 'tools.list'.rotate_left

local function rotate_around(col, sep, line)
  -- dbg()
  local pattern = "[%w_" .. sep .. "]+"
  local chunk = st.match_at(line,  col + 1, pattern)
  local parts = st.split(chunk.chunk(), sep)
  return chunk.replace(table.concat(rotate_left(parts), sep)).string()
end

return {
  rotate_around = rotate_around
}
