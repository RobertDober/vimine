local replace = require'tools.list'.replace

local _subject
local function subject(a_list)
  _subject = a_list
end

local two = {"a", "b"}

describe("replace", function()
  describe("into an empty", function()
    local result = replace({}, 1, 2, two) 
    it("ignores indices", function()
      assert.are.same(two, result)
    end)
  end)
end)
