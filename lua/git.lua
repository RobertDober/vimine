-- local dbg = require("debugger")
-- dbg.auto_where = 2
local T = require'tools'()
local map = require'tools.fn'.map
local _context = require'context'
local context
local api

local function find(from, pattern)
  for lnb = from, api.line_count() do
    if string.match(api.line_at(lnb), pattern) then
      return lnb
    end
  end
  error("No line matching " .. pattern .. " found")
end

local function init_context()
  context = _context.context()
  api     = context.api
  if not string.match(context.line, "^<<<<<<<") then
    error("Not on first line of a merge")
  end
  local first_lnb = context.lnb
  local mid_lnb   = find(first_lnb + 1, "^=======")
  local last_lnb  = find(mid_lnb + 1, "^>>>>>>>")
  return {first_lnb, mid_lnb, last_lnb}
end

local function take_current()
  local lnbs = init_context()
  api.delete_lines(lnbs[2], lnbs[3])
  api.delete_lines(lnbs[1], lnbs[1])
end

local function take_incoming()
  local lnbs = init_context()
  api.delete_lines(lnbs[3], lnbs[3])
  api.delete_lines(lnbs[1], lnbs[2])
end

return {
  take_current = take_current,
  take_incoming = take_incoming
}
