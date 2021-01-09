-- local dbg = require("debugger")
-- dbg.auto_where = 2
local lst = require 'tools.list'
local split = require'tools.string'.split

local _buffer = {
  cursor = {1, 0},
  lines = {},
  filename = "",
  path = ""
}

local _called = {
}

local _commands = {

}
local _options = {
}

local _evaluations = {
}

local _marks = {
}

local _variables = {
}

local _vim = {
  api = {
    nvim_call_function = function(fname, params)
      table.insert(_called, {fname, params})
    end,
    nvim_command = function(cmd)
      table.insert(_commands, cmd)
    end,
    nvim_get_current_line = function()
      return _buffer.lines[_buffer.cursor[1]]
    end,
    nvim_win_get_cursor = function(_)
      return _buffer.cursor
    end,
    nvim_buf_get_lines = function(_, lnb1, lnb2, _)
      local lnb2 = lnb2
      if lnb2 < 0 then
        lnb2 = #_buffer.lines + 1 + lnb2
      end
      return lst.slice(_buffer.lines, lnb1 + 1, lnb2)
    end,
    nvim_buf_get_mark = function(_, mark)
      return _marks[mark] or {0, 0}
    end,
    nvim_buf_get_option = function(_, name)
      return _options[name]
    end,
    nvim_eval = function(cmd)
      return _evaluations[cmd]
    end,
    nvim_get_var = function(name)
      return _variables[name]
    end,
    nvim_win_set_cursor = function(_, cursor)
      _buffer.cursor = cursor
    end,
    nvim_buf_set_lines = function(_, lnb1, lnb2, _, lines)
      _buffer.lines = lst.replace(_buffer.lines, lnb1 + 1, lnb2, lines)
    end,

    -- for inspection in tests
    _called = function() return _called end,
    _executed_commands = function() return _commands end,
  },
  inspect = tostring,
  __stubbed__ = true,
}


vim = vim or _vim

local stubber_api = {
  evaluation = function(cmd, result)
    _evaluations[cmd] = result
  end,
  cursor = function(...)
    _buffer.cursor = {...}
  end,
  lines = function(...)
    _buffer.lines = {...}
  end,
  option = function(key, value)
    _options[key] = value
  end,
  set_mark = function(mark, position)
    _marks[mark] = position
  end,
  var = function(key, value)
    _variables[key] = value
  end,
}

local function _set_marks_for_selection(selection)
  _marks["<"] = selection[1]
  _marks[">"] = selection[2]
end

local function _stub_path(path)
  local filename = split(path, "/")
  filename = filename[#filename]
  _evaluations['expand("%")'] = path
  _evaluations['expand("%:t")'] = filename
  _buffer.path = path
  _buffer.filename = filename
end

local function _stub_vim(params)
  if params.evaluation then
    _evaluations[params.evaluation[1]] = params.evaluation[2]
  end
  if params.cursor then
    _buffer.cursor = params.cursor
  end
  if params.lines then
    _buffer.lines = params.lines
  end
  if params.option then
    _options[params.option[1]] = params.option[2]
  end
  if params.ft then
    _options["filetype"] = params.ft
  end
  if params.path then
    _stub_path(params.path)
  end
  if params.selection then
    _set_marks_for_selection(params.selection)
  end
  if params.var then
    _variables[params.var[1]] = params.var[2]
  end
end

return {
  stub_vim = _stub_vim,
  stubber = stubber_api,
}
