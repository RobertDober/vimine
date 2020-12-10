local append = require'tools.list'.append

describe("append", function()
  describe("with modif", function()
    local head = {"a", "b", "c"}
    local tail = {"d", "e", "f"}
    local result = append(head, tail, string.upper)
    it("can transform the suffix", function()
      assert.are.same({"A", "B", "C", "D", "E", "F"}, result)
    end)
    it("did not change any param", function()
      assert.are.same({"a", "b", "c"}, head)
      assert.are.same({"d", "e", "f"}, tail)
    end)
  end)
end)
