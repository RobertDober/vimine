local foldl = require'tools.fn'.foldl

local function add(a,b)
  return a + b
end

describe("foldl", function()
  describe("w/o an initial value", function()
    it("takes the first one of the list", function()
      assert.is_equal(foldl({1, 2}, add), 3)
    end)
    it("takes the first one of the list - edge case", function()
      assert.is_equal(foldl({2}, add), 2)
    end)
    it("does not like empty lists w/o an initial value", function()
      assert.has_error(function()
        foldl({}, add)
      end)
    end)

    describe("with an initial value", function()
      it("uses the whole list", function()
        assert.is_equal(foldl({1, 2, 3}, add, 4), 10)
      end)
    end)
  end)

end)
