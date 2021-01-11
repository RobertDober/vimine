-- local dbg = require("debugger")
-- dbg.auto_where = 2

local stack_methods = {
  is_empty = function(self)
    return #self.stack == 0 
  end,
  peek = function(self)
    if #self.stack == 0 then
      error "Must not peek into an empty stack -- beware of the abyss"
    end
    return self.stack[#self.stack]
  end,
  pop = function(self)
    if #self.stack == 0 then
      error "Must not pop from empty stack"
    end
    -- print(self.stack[1], self.stack[2])
    return table.remove(self.stack, #self.stack)
  end,
  push = function(self, value)
    table.insert(self.stack, value)
  end,
  to_list = function(self)
    local result = {}
    for _, v in ipairs(self.stack) do
      table.insert(result, v)
    end
    return result
  end
}
stack_methods.__index = stack_methods

local function make_new_stack()
  local o = {stack = {}}
  setmetatable(o, stack_methods)
  return o  
end



return {
  new = make_new_stack
}
