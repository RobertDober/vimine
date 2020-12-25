-- local dbg = require("debugger")
-- dbg.auto_where = 2
local match_any_of = require'tools'().match_any_of

local function state_machine(states)
  local current_state
  local current_triggers

  local function match(line, pattern)
    if type(pattern) == "string" then
      return string.match(line, pattern)
    elseif type(pattern) == "table" then
      return match_any_of(line, pattern)
    elseif type(pattern) == "function" then
      return pattern(line)
    else
      return pattern
    end
  end
  local function set_state(state)
    if not state or (current_state == state) then return end
    current_state = state
    current_triggers = states[current_state]
    if not current_triggers then
      error("Undefined state: " .. state)
    end
  end

  local function trigger(line, match, action, acc)
    -- dbg()
    local new
    if type(action) == "function" then
      acc, new = action(line, match, acc)
      set_state(new)
      return acc
    elseif type(action) == "string" then
      set_state(action)
      return acc
    end
  end

  local function transition(line, acc)
    for _ , pattern_action in ipairs(current_triggers) do
      -- print("candidate", vim.inspect(pattern_action))
      pattern = pattern_action[1]
      action = pattern_action[2]
      local m = match(line, pattern)
      if m then
        -- print("matched", vim.inspect(pattern))
        return trigger(line, m, action, acc) 
      end
    end
    return acc
  end

  return function(input, acc, start_state)
    set_state(start_start or "start")
    for _, line in ipairs(input) do
      -- print("state", current_state, "line", line, "out", #acc)
      acc = transition(line, acc)
    end
    return acc
  end

end

return {
  state_machine = state_machine
}
