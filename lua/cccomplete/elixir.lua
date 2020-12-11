-- local dbg = require("debugger")
-- -- Consider enabling auto_where to make stepping through code easier to follow.
-- dbg.auto_where = 2
local T = require "tools"()
local H = require "cccomplete.helpers"()

local function fn_complete_bare(line)
  local line = string.gsub(line, "%s*$", "")
  return H.complete_with_end(line)
end

local fn_patterns = { 
  ["%s+->%s+$"] = fn_complete_bare,
}

local function fn_complete_docstring(with)
  local with = with or ""
  return function(line)
    local line = string.gsub(line, ">", with .. ">")
    local number = string.match(line, "([(]%d+[)])")
    return H.make_return_object{lines = {line, H.indent(line) .. "..." .. number .. "> "}} 
  end
end
local doctest_patterns = {
  ["^%s%s%s%s+iex>"] = fn_complete_docstring("(0)"),
  ["^%s%s%s%s+[.][.][.]>"] = fn_complete_docstring("(0)"),
  ["^%s%s%s%s+iex[(]%d+[)]>"] = fn_complete_docstring(),
  ["^%s%s%s%s+[.][.][.][(]%d+[)]>"] = fn_complete_docstring(),
}
return function()
  local function complete(line)
    local fn_completer = T.access_by_match(line, doctest_patterns)
    if fn_completer then return fn_completer(line) end

    fn_completer = T.access_by_match(line, fn_patterns)
    if fn_completer then return fn_completer(line) end

    return H.complete_with_do(line)
  end

  return {
    complete = complete
  }
end
