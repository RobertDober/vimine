local flat_map = require 'tools.fn'.flat_map
local id = require 'tools.fn'.id

describe("flat_map", function()
  local function expander(n)
    return {2 * n, 2 * n + 1}
  end

  describe("empty", function()
    it("is empty", function()
      assert.is_equal(#flat_map({}, expander), 0)
    end)
  end)

  describe("not empty", function()
    it("has expanded values", function()
      assert.are.same({2, 3, 4, 5}, flat_map({1, 2}, expander))
    end)
    it("works with scalars do", function()
      assert.are.same({1, 2}, flat_map({1, 2}, id))
    end)
  end)
end)
