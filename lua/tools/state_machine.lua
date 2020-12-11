-- local dbg = require("debugger")
-- -- Consider enabling auto_where to make stepping through code easier to follow.
-- dbg.auto_where = 2
local function state_machine(description)
  local states = description.states
  local current_state
  local current_description

  local function set_state(state)
    if not state or (current_state == state) then return end
    current_state = state
    current_description = states[current_state]
    if not current_description then
      error("Undefined state: " .. state)
    end
  end

  local function trigger(line, match, action, acc)
    -- dbg()
    local new
    if type(action) == "function" then
      acc, new = action(line, match, acc)
      -- print("acc", acc, "new", new)
      set_state(new)
      return acc
    elseif type(action) == "string" then
      set_state(action)
      return acc
    end
  end

  local function transition(line, acc)
    for _ , pattern_action in ipairs(current_description) do
      pattern, action = table.unpack(pattern_action)
      local m = string.match(line, pattern)
      if m then
        return trigger(line, m, action, acc) 
      end
    end
    return acc
  end

  return function(input, acc)
    set_state(description.start or "start")
    for _, line in ipairs(input) do
      -- print("state", current_state, "line", line, "acc", acc)
      acc = transition(line, acc)
    end
    return acc
  end

end

return {
  state_machine = state_machine
}
