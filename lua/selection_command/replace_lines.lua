-- local dbg = require("debugger")
-- dbg.auto_where = 2
--
local find_match = require 'tools.fn'.find_match
local flatten = require 'tools.list'.flatten

local function wrap_rubocop_around(lines, cop)
  local prefix = string.gsub(lines[1], '[^%s].*$', '')
  return flatten(
    prefix .. "# rubocop:disable " .. cop,
    lines,
    prefix .. "# rubocop:enable " .. cop)
end

local commands = {
  rubocop = wrap_rubocop_around,
}
return function(lines, cmd, ...)
  local cmd_function = find_match(commands, cmd)
  if not cmd_function then return lines end
  return cmd_function(lines, ...)
end

