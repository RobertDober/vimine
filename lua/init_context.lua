-- local dbg = require("debugger")
-- dbg.auto_where = 2

local _context = require'context'
context = 'null'
api = 'null'

local function run()
  context = _context.context()
  api = require'nvimapi'
end

return {
  run = run
}
