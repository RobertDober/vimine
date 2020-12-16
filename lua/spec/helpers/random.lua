local dbg = require("debugger")
dbg.auto_where = 2
local fn = require'tools.fn'

local data = "abcdefghijklmnopqrstuvwxyz_1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ"

local function random_char(from)
  local idx = math.random(1, #from)
  return string.sub(from, idx, idx)
end
local function random_string(prefix, len, from)
  local len = len or 8
  local from = from or data
  local prefix = prefix or ""
  return prefix .. table.concat(fn.map(fn.range(1, len), fn.curry(random_char, from)))
end

local function random_strings(prefix, n)
  local function replace_number(str, n)
    return string.gsub(str, "%%n", n)
  end
  return fn.map(fn.range(1, n), function(i) return string.gsub(prefix, "%%n", i) .. random_string() end)
end

return {
  random_string = random_string,
  random_strings = random_strings,
}
