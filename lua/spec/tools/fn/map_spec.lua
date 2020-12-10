local map = require 'tools.fn'.map

describe("map", function()
  local function doubler(n)
    return 2 * n
  end

  describe("empty", function()
    it("is empty", function()
      assert.is_equal(#map({}, doubler), 0)
    end)
  end)

  describe("not empty", function()
    it("has doubled values", function()
      assert.are.same({2, 4}, map({1, 2}, doubler))
    end)
  end)
end)
