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

local function fn_continue_pipe(line)
  return H.make_return_object{lines = {line, H.indent(line, "|> ")}}
end
local function fn_first_pipe(line)
  local line = string.gsub(line, "%s*>%s*$", "")
  return H.make_return_object{lines = {line, H.indent(line, "|> ")}}
end

local pipe_patterns = {
  ["%s>%s*$"] = fn_first_pipe,
  ["^%s*|>%s"] = fn_continue_pipe
}

local function fn_doctest(line)
  return H.make_return_object{lines = {line, H.indent(line), H.indent(line, '"""')}}
end
local docstring_patterns = {
  ['^%s*@doc%s+"""'] = fn_doctest,
  ['^%s*@moduledoc%s+"""'] = fn_doctest,
}

local all_patterns = {
  doctest_patterns, docstring_patterns, pipe_patterns, fn_patterns
}
return function()
  local function complete(line)
    return H.complete_from_patterns(line, all_patterns, H.complete_with_do)
  end

  return {
    complete = complete
  }
end
