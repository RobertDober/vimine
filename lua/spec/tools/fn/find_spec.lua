-- local dbg = require("debugger")
-- dbg.auto_where = 2
local find = require'tools.fn'.find
local find_match = require'tools.fn'.find_match

local patterns = {
  ["%w"] = 'alnum',
  ["%s"] = 'space' 
}

describe("find", function()
   it("finds an alnum", function()
     local result = find(patterns, function(pattern)
       return string.match("a", pattern)
     end)
     assert.is_equal(result, 'alnum')
   end)
   it("finds a space", function()
     local result = find(patterns, function(pattern)
       return string.match(" ", pattern)
     end)
     assert.is_equal(result, 'space')
   end)
end)

describe("find_match", function()
   it("finds an alnum", function()
     local result = find_match(patterns, "a")
     assert.is_equal(result, 'alnum')
   end)
   it("finds a space", function()
     local result = find_match(patterns, " ")
     assert.is_equal(result, 'space')
   end)
   it("also might not find a value", function()
     assert.is_nil(find_match(patterns, "%"))
   end)
end)
