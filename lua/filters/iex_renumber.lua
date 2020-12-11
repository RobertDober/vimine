local sm = require 'tools.state_machine'.state_machine

local iex_line_patterns = {
  "^%s%s%s%s+iex>",
  "^%s%s%s%s+iex[(]%d+[)]>",
  "^%s%s%s%s+[.][.][.]>",
  "^%s%s%s%s+[.][.][.][(]%d+[)]>",
}
local function back_to_start(line, _match, acc)
  table.insert(acc.lines, line)
  acc.count = acc.count + 1
  return acc, "start"
end

local function copy_line(line, _match, acc)
  table.insert(acc.lines, line)
  return acc
end

local function into_iex(iex_prompt)
  return function(line, match, acc)
    local new_line = line:sub(0, #match-1)
    new_line = string.gsub(new_line, "[(]%d+[)]$" , "")
    new_line = new_line:sub(0, -4) 
    table.insert(acc.lines, new_line .. iex_prompt .. "(" .. acc.count .. ")>" .. line:sub(#match+1, -1))
    return acc, "iex"
  end
end

local state_machine = sm{
  start = {
    { iex_line_patterns, into_iex("iex") },
    { true, copy_line }
  },
  iex = {
    { iex_line_patterns, into_iex("...") },
    { true, back_to_start }
  }
}

return function(lines)
  return state_machine(lines, {lines={}, count=0}).lines
end
