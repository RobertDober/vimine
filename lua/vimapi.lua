-- a convenience API wrapper
-- replacing vim.api.nvim_xxxx by proxy.xxxx
local api = vim.api

local proxy = {
  get_mark = function(mark)
    return api.nvim_buf_get_mark(0, mark)
  end,
  normal_command = function(normal)
    api.nvim_command("normal "..normal)
  end,
  system = function(cmd)
    api.nvim_call_function("system", {cmd})
  end
}

local function set_proxy(from_name)
  proxy[from_name] = api['nvim_'..from_name]
  return proxy[from_name]
end

local metatable = {
  __index = function(_, k) return set_proxy(k) end
}
setmetatable(proxy, metatable)

return proxy
