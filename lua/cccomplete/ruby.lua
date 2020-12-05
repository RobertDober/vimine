local indent = require "cccomplete.helpers"().indent

local ruby_no_do = "^%s*(%a+)"
local ruby_no_dos = {
  module = true,
  class = true,
  def = true,
}

return function()

  local function complete_ruby_no_do(line)
    return {
      lines = {
        line,
        indent(line) .. "  ",
        indent(line) .. "end"
      },
      offset = 1,
      col = 999
    }
  end

  local function complete_ruby_do(line)
    local line = string.gsub(line, "%s+do%s*$", "")
    print("doline", line)
    return {
      lines = {
        line .. " do",
        indent(line) .. "  ",
        indent(line) .. "end"
      },
      offset = 1,
      col = 999
    }
  end


  local function complete(line)
    no_do = ruby_no_dos[string.match(line, ruby_no_do)] 
    if no_do then
      return complete_ruby_no_do(line)
    else
      return complete_ruby_do(line)
    end
  end


  return {
    complete = complete
  }
end
