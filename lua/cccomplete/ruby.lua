local indent = require "cccomplete.helpers"().indent
local complete_with_do = require "cccomplete.helpers"().complete_with_do
local complete_with_end = require "cccomplete.helpers"().complete_with_end

local ruby_no_do = "^%s*(%a+)"
local ruby_no_dos = {
  module = true,
  class = true,
  def = true,
}

return function()


  local function complete(ctxt)
    local line = ctxt.line
    local no_do = ruby_no_dos[string.match(line, ruby_no_do)] 
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
