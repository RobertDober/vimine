local T = require "tools"()
local H = require "cccomplete.helpers"()

local function fn_complete_bare(line)
  local line = string.gsub(line, "%s*$", "")
  return H.complete_with_end(line)
end

local fn_patterns = { 
  ["%s+->%s+$"] = fn_complete_bare,
}
return function()
  local function complete(line)
    fn_completer = T.access_by_match(line, fn_patterns)
    if fn_completer then return fn_completer(line) end
    return H.complete_with_do(line)
  end

  return {
    complete = complete
  }
end
