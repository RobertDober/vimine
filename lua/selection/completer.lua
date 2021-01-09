-- local dbg = require("debugger")
-- dbg.auto_where = 2
local L = require'tools.list'
local F = require'tools.fn'
local S = require'tools.string'

local function split_and_sort(sep)
  return function(subject)
    local parts = S.split(subject.chunk.chunk(), sep)
    table.sort(parts)
    return table.concat(parts, sep)
  end
end

local function sort(selection, sep)
  local sep = sep[1]
  return F.map(selection, split_and_sort(sep))
end

local all_completers = {
  sort = sort,
}

local function complete(selection, ...)
  local args = {...}
  local verb = args[1]
  local completer = all_completers[verb]
  if not completer then
    return {} -- NOP
  end
  return completer(selection, L.slice(args, 2, -1))
end

return {
  complete = complete
}
