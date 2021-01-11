-- local dbg = require("debugger")
-- dbg.auto_where = 2
local C = require'context'
local L = require'tools.list'
local complete = require'selection.completer'.complete
local api = require'nvimapi'

local function execute(...)
  local ctxt  = C.context()
  local api = ctxt.api
  local selection = C.get_selection() 
  local result = complete(selection, ...)
  C.set_selection(result)
  -- if result then
  --   api.set_lines(ctxt.lnb, ctxt.lnb, result.lines)
  --   api.set_cursor(ctxt.lnb+result.offset, result.col)
  -- end
end

local function rubocop_command(lines, cop)
  local prefix = string.gsub(lines[1], '[^%s].*$', '')
  return L.flatten(
    prefix .. "# rubocop:disable " .. cop,
    lines,
    prefix .. "# rubocop:enable " .. cop)
end

local defined_lines_commands = {
  rubocop = rubocop_command,
}

local function execute_lines_command(lines, command, ...)
  local command = defined_lines_commands[command]
  if not command then return lines end
  return command(lines, ...)
end

local function execute_lines(...)
  local fl, ll, lines = api.get_selected_lines()
  local result = execute_lines_command(lines, ...)
  api.set_lines(fl, ll, result)
end

return {
  execute = execute,
  execute_lines = execute_lines
}
