local indent = require "cccomplete.helpers"().indent
local complete_with_do = require "cccomplete.helpers"().complete_with_do
local complete_with_end = require "cccomplete.helpers"().complete_with_end

local crystal_no_do = "^%s*(%a+)"
local crystal_no_dos = {
  class = true,
  def = true,
  module = true,
  struct = true,
}

return function()


  local function complete(ctxt)
    local line = ctxt.line
    local no_do = crystal_no_dos[string.match(line, crystal_no_do)] 
    if no_do then
      return complete_with_end(line)
    else
      return complete_with_do(ctxt)
    end
  end

  return {
    complete = complete
  }
end
