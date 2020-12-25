-- local dbg = require("debugger")
-- dbg.auto_where = 2
local fn = require'tools.fn'

local lower_case = "abcdefghijklmnopqrstuvwxyz"
local upper_case = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local digits     = "1234567890"
local data       = lower_case .. upper_case .. digits .. "_"

local function iter(l)
  local i = 0
  local n = #l 
  return function()
    i = i + 1
    if i <= n then return l[i] end
  end
end

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

local function sample_from(range)
  return math.random(range[1], range[2])
end

local function samples_from(range, count)
  local count = count or 1
  local result = {}
  for _ = 1, count do
    table.insert(result, sample_from(range))
  end
  return result
end

local function random_words(from, count, size)
  local size = size or #from
  local result = {}
  for _, len in ipairs(samples_from({1, size}, count)) do
    table.insert(result, random_string("", len, from))
  end
  return iter(result)
end

return {
  alnum_chars    = data,
  digits         = digits,
  lower_case     = lower_case,
  upper_case     = upper_case,
  random_string  = random_string,
  random_strings = random_strings,
  random_words   = random_words,
  samples_from   = samples_from,
}
