-- local dbg = require("debugger")
-- dbg.auto_where = 2
local A = require "tools.active_support"
local T = require "tools"()
local H = require "cccomplete.helpers"()
local S = require "tools.string"
local F = require "tools.fn"
local L = require "tools.list"
local equals = require'tools.functors'.equals

local function _upt_to_lib(path)
  local segments = S.split(path, "/")
  local tail     = L.tail_from(segments, equals("lib"))
  return table.concat(tail, "/")
end

local function defmodule_completion(ctxt)
  if string.match(ctxt.line, "^module%s*$") then
    local path = _upt_to_lib(ctxt.file_path)
    local lines = {
      "defmodule " .. A.camelize_path(path) .. " do",
      "  ",
      "end"
    }
    return H.make_return_object{lines = lines, offset = 1}
  end
end

local function test_completion(ctxt)
  if string.match(ctxt.line, "^module%s*$") then
    local lines = {
      "defmodule " .. A.camelize_path(ctxt.file_path) .. " do",
      "  use ExUnit.Case",
      "",
      "  ",
      "end"
    }
    return H.make_return_object{lines = lines, offset = 3}
  end
end

local function complete_special(ctxt)
  local file_name = ctxt.file_name
  if not file_name then
    return nil
  end
  if string.match(file_name, "_test[.]exs$") then
    return test_completion(ctxt)
  else
    return defmodule_completion(ctxt)
  end
end

local function fn_complete_bare(ctxt)
  local line = string.gsub(ctxt.line, "%s*$", "")
  return H.complete_with_end(line)
end

local fn_patterns = {
  ["%s+->%s+$"] = fn_complete_bare,
}

local function fn_complete_first_docstring(with)
  local with = with or ""
  return function(ctxt)
    local line = string.gsub(ctxt.line, ">%s*", with .. "> ")
    return H.make_return_object{lines = {line}, offset = 0}
  end
end
local function fn_complete_docstring(with)
  local with = with or ""
  return function(ctxt)
    local line = string.gsub(ctxt.line, ">", with .. ">")
    local number = string.match(line, "([(]%d+[)])")
    return H.make_return_object{lines = {line, H.indent(line) .. "..." .. number .. "> "}}
  end
end
local doctest_patterns = {
  ["^%s%s%s%s+iex>"] = fn_complete_first_docstring("(0)"),
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
local function fn_pure_docstring(ctxt)
  local doctype = "@" .. string.match(ctxt.line, '^%s*(%w+)$')
  return H.make_return_object{lines = {H.indent(ctxt.line, doctype .. ' """'), H.indent(ctxt.line), H.indent(ctxt.line, '"""')}}
end
local docstring_patterns = {
  ['^%s*doc$'] = fn_pure_docstring,
  ['^%s*moduledoc$'] = fn_pure_docstring,
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
    local special_completion = complete_special(ctxt)
    if special_completion then
      return special_completion
    end
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
