-- a convenience API wrapper
local api = vim.api

local proxy = {}
local function set_proxy(from_name)
  proxy[from_name] = api['nvim_'..from_name]
end
-- use a metatable to assure that xxx is accessing api["nvim_"..xxx]
return {

}
