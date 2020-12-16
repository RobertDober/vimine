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
  describe("not replacing anything", function()
    it("inserts before line #1 #wip", function()
      local result = replace(two, 1, 0, {"x"})
      assert.are.same({"x", "a", "b"}, result)
    end)
    it("inserts after line #1", function()
      local result = replace(two, 2, 1, {"x"})
      assert.are.same({"a", "x", "b"}, result)
    end)
    it("inserts at the end", function()
      local result = replace(two, 3, 1, {"x"})
      assert.are.same({"a", "b", "x"}, result)
    end)
  end)

  describe("replace one line", function()
    it("replaces the line with 0 based index", function()
      local result = replace(two, 0, 1, {"y","z"})
      assert.are.same({"y", "z", "b"}, result)
    end)
  end)

  describe("replace all", function()
    it("can have an empty result", function()
      local result = replace(two, 0, 2, {})
      assert.are.same({}, result)
    end)
    it("or not", function()
      local result = replace(two, 0, 2, {"alpha"})
      assert.are.same({"alpha"}, result)
    end)
  end)
end)
