local indent = require "cccomplete.helpers"().indent
local complete_with_do = require "cccomplete.helpers"().complete_with_do

return function()
  local function complete(line)
    return complete_with_do(line)
  end

  return {
    complete = complete
  }
end
