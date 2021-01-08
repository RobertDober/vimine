-- local dbg = require("debugger")
-- dbg.auto_where = 2

local function const_fn(retval)
  return function()
    return retval
  end
end
local function equals(subject)
  return function(with)
    return subject == with
  end
end

return {
  const_fn = const_fn,
  equals = equals,
}
