-- local dbg = require("debugger")
-- dbg.auto_where = 2
local H = require "cccomplete.helpers"()

-- local rust_no_do = "^%s*(%a+)"
-- local rust_no_dos = {
--   module = true,
--   class = true,
--   def = true,
-- }

local function fn_completion(ctxt)
  if string.match(ctxt.line, "%b()") then
    return
  end
  local line = string.gsub(ctxt.line, "%s*{?%s*$", "") .. "() {"
  return H.make_return_object{lines = {line, H.indent(line, "    "), H.indent(line, "}") }} 

end
local rust_patterns = {
  ['^%s*fn'] = fn_completion,
  ['^%s*pub%s+fn'] = fn_completion,
}

local function default_completion(line)
  local line = string.gsub(line, "%s*{?%s*$", "") .. " {"
  return H.make_return_object{lines = {line, H.indent(line, "    "), H.indent(line, "}") }} 
end

return function()
  local function complete(ctxt)
    local completion = H.complete_from_patterns(ctxt, rust_patterns)
    if completion then
      return completion
    end
    return default_completion(ctxt.line)
  end

  return {
    complete = complete
  }
end
