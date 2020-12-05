require("cccomplete/completer")

local ruby_no_do = "^%s*(%a+)"
local ruby_no_dos = {
  module = true,
  class = true,
  def = true,
}

RubyCompleter = Completer:new(nil)

function RubyCompleter:complete()
  no_do = ruby_no_dos[string.match(self.line, ruby_no_do)] 
  if no_do then
    return self:complete_ruby_no_do()
  else
    return self:complete_ruby_do()
  end
end


function RubyCompleter:complete_ruby_no_do()
  return {
    lines = {
      self.line,
      self.indent .. "  ",
      self.indent .. "end"
    },
    offset = 1,
    col = 999
  }
end

function RubyCompleter:complete_ruby_do()
  local line = string.gsub(self.line, "%s+do%s*$", "")
  print("doline", line)
  return {
    lines = {
      line .. " do",
      self.indent .. "  ",
      self.indent .. "end"
    },
    offset = 1,
    col = 999
  }
end
