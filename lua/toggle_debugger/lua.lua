local api = require'nvimapi'

local commented_header = "^--%s+.*require[(][\"']debugger[\"'][)]"
local uncommented_header = "require[(][\"']debugger[\"'][)]"  

local debugger_header = {
  'local dbg = require("debugger")',
  'dbg.auto_where = 2'
}

local function insert_debugger_header()
  api.set_lines(1, 0, debugger_header)
  api.set_cursor(api.cursor()[1] + 2)
end

local function uncomment()
  local nl1 = string.gsub(api.line_at(1), '^--%s+', '')
  local nl2 = string.gsub(api.line_at(2), '^--%s+', '')
  api.set_lines(1, 2, {nl1, nl2})
end

local function debugger_is_active()
  if string.match(api.line_at(1), commented_header) then
    return false
  end
  if string.match(api.line_at(1), uncommented_header) then
    return true
  end
  return false
end

local function activate_debugger()
  if string.match(api.line_at(1), commented_header) then
    uncomment()
  else
    insert_debugger_header()
  end
end

local function comment()
  local nl1 = "-- " .. api.line_at(1)
  local nl2 = "-- " .. api.line_at(2) 
  api.set_lines(1, 2, {nl1, nl2})
  api.command("g/^\\s*dbg()/d")
end

return {
  toggle = function(_ctxt)
    if debugger_is_active() then
      comment()
    else
      activate_debugger()
    end
  end
}
