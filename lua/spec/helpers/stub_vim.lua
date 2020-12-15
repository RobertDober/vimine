local dbg = require("debugger")
dbg.auto_where = 2
local slice = require 'tools.list'.slice
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
      return slice(_buffer.lines, lnb1 + 1, lnb2)
    end,
    nvim_buf_get_option = function(_, name)
      return _options[name]
    end,
    nvim_eval = function(cmd)
      return _commands[cmd]
    end,
  },
  inspect = tostring,
  __stubbed__ = true,
}

_vim.nvim_get_cursor = function(_)
  return _buffer.cursor
end

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

return function(stubber)
  stubber(stubber_api)
end
