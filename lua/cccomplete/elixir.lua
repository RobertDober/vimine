-- local = local, = local, dbg = require("debugger")
-- dbg.auto_where = 2
local T = require "tools"()
local H = require "cccomplete.helpers"()

local function fn_complete_bare(ctxt)
  local line = string.gsub(ctxt.line, "%s*$", "")
  return H.complete_with_end(line)
end

local fn_patterns = { 
  ["%s+->%s+$"] = fn_complete_bare,
}

local function fn_complete_docstring(with)
  local with = with or ""
  return function(ctxt)
    local line = string.gsub(ctxt.line, ">", with .. ">")
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

local function fn_continue_pipe(ctxt)
  return H.make_return_object{lines = {ctxt.line, H.indent(ctxt.line, "|> ")}}
end
local function fn_first_pipe(ctxt)
  local line = string.gsub(ctxt.line, "%s*>%s*$", "")
  return H.make_return_object{lines = {line, H.indent(line, "|> ")}}
end

local pipe_patterns = {
  ["%s>%s*$"] = fn_first_pipe,
  ["^%s*|>%s"] = fn_continue_pipe
}

local function fn_doctest(ctxt)
  return H.make_return_object{lines = {ctxt.line, H.indent(ctxt.line), H.indent(ctxt.line, '"""')}}
end
local docstring_patterns = {
  ['^%s*@doc%s+"""'] = fn_doctest,
  ['^%s*@moduledoc%s+"""'] = fn_doctest,
}

local function spec_complete(ctxt)
  local fun_name = string.match(ctxt.post_line, "^%s*defp?%s([%w_?!]+)")
  if fun_name then
    local line = H.indent(ctxt.post_line) .. "@spec " .. fun_name .. "("
    return H.make_return_object{lines = {line}, offset = 0}
  end
end
local spec_patterns = {
  ['^%s*spec'] = spec_complete,
}
local all_patterns = {
  doctest_patterns, docstring_patterns, pipe_patterns, fn_patterns, spec_patterns
}
return function()
  local function complete(ctxt)
    local completion = H.complete_from_patterns(ctxt, all_patterns)
    if completion then
      return completion
    else
      return H.complete_with_do(ctxt)
    end
  end

  return {
    complete = complete
  }
end
