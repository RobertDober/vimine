local fn = require'tools.fn'

describe("curry", function()
  local function add(a, b) return a + b end
  local inc = fn.curry(add, 1)
  it("can increment", function()
    assert.is_equal(42, inc(41))
  end)

  describe("this can be very useful with fn tools", function()
    it("e.g. with map", function()
      assert.are.same({1, 2}, fn.map({0, 1}, inc)) 
    end)

    it("can simulate foldl", function()
      local result = {}
      local add_to = fn.curry(table.insert, result)
      fn.each({1, 2}, add_to)
      assert.are.same({1, 2}, result)
    end)
  end)
end)
