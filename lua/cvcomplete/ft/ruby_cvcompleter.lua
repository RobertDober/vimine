-- local dbg = require("debugger")
-- dbg.auto_where = 2

local find_match = require'tools.fn'.find_match

local function ruby_sym_to_sq(selection)
  return "'" .. selection:sub(2) .. "'"
end
local function ruby_sq_to_dq(selection)
  return '"' .. selection:sub(2, #selection - 1) .. '"'
end
local function ruby_dq_to_sym(selection,col)
  return ":" .. selection:sub(2, #selection - 1)
end
local ruby_toggles = {
  ["^:[%a_][%a%d_]+$"] = ruby_sym_to_sq,
  ["^'[%a_][%a%d_]+'$"] = ruby_sq_to_dq,
  ['^"[%a_][%a%d_]+"$'] = ruby_dq_to_sym,
}

return function(sel)
  local kind = find_match(ruby_toggles, sel)
  if kind then
    return kind(sel)
  end
end


