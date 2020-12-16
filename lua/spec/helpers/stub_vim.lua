-- local dbg = require("debugger")
-- dbg.auto_where = 2
local lst = require 'tools.list'
local _buffer = {
  cursor = {1, 0},
  lines = {},
}

local _options = {
}

local _commands = {
}

local _vim = {
  api = {
    nvim_get_current_line = function()
      return _buffer.lines[_buffer.cursor[1]]
    end,
      
    nvim_win_get_cursor = function(_)
      return _buffer.cursor
    end,
    nvim_buf_get_lines = function(_, lnb1, lnb2, _)
      return lst.slice(_buffer.lines, lnb1 + 1, lnb2)
    end,
    nvim_buf_get_option = function(_, name)
      return _options[name]
    end,
    nvim_eval = function(cmd)
      return _commands[cmd]
    end,
    nvim_win_set_cursor = function(_, cursor)
      _buffer.cursor = cursor
    end,
    nvim_buf_set_lines = function(_, lnb1, lnb2, _, lines)
      _buffer.lines = lst.replace(_buffer.lines, lnb1 + 1, lnb2, lines)
    end
  },
  inspect = tostring,
  __stubbed__ = true,
}


vim = vim or _vim

local stubber_api = {
  command = function(cmd, result)
    _commands[cmd] = result
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

}

local function _stub_vim(...)
  local params = {...}
  
end

return {
  stub    = _stub_vim,
  stubber = stubber_api,
}
