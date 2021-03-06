local nop = require "cccomplete.helpers"().nop

local trigger = "^(%u%a+)[%s,:]"
local bare    = "^(%u%a+)$"
local gherkin_like = {
  And   = true,
  But   = true,
  Example = true,
  Given = true,
  However = true,
  Then  = true,
  When  = true,
}
gherkin_like["Example:"] = true

return function()

  local function complete_ruby(line)
    return {
      lines = {
        line,
        "```ruby", 
        "    ",
        "```"
      },
      offset = 2,
      col = 5
    }
  end

  local function complete(ctxt)
    local line = ctxt.line
    local match = string.match(line, trigger) or string.match(line, bare)

    if match then
      if gherkin_like[match] then
        return complete_ruby(line)
      end
    end
    return nop(line)
  end

  return {
    complete = complete
  }
end
