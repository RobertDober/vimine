Completer = {}

function Completer:new(o, line)
  o = o or {}
  line = line or ""
  setmetatable(o, self)
  self.__index = self
  self.line = line or ""
  self.indent = string.match(self.line, "^%s*")
  return o
end
