-- local dbg = require("debugger")
-- dbg.auto_where = 2
local fn = require'tools.fn'

describe("curry", function()
  local function add(a, b) return a + b end
  local inc = fn.curry(add, 1)
  local answer = fn.curry(add, 1, 41)

  it("can increment", function()
    assert.is_equal(42, inc(41))
  end)
  it("can be called", function()
    assert.is_equal(42, answer())
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

describe("positional curry", function()
  local function four(a,b,c,d) return 1000*a + 100*b + 10*c + d end
  describe("fixed units", function()
    local fixed = fn.curry_at(four, fn.free, fn.free, fn.free, 1)
    it("delivers", function()
      assert.is_equal(4321, fixed(4, 3, 2))
    end)
  end)
  describe("two twos", function()
    local fixed = fn.curry_at(four, fn.free, 2, 3)
    it("delivers", function()
      assert.is_equal(1234, fixed(1, 4))
    end)
  end)
  describe("all given", function()
    local fixed = fn.curry_at(four, 9, 8, 7, 6)
    it("delivers", function()
      assert.is_equal(9876, fixed())
    end)
  end)
end)

describe("keyword curry", function()
  local function comp(data)
    return data.factor * 10 + data.offset
  end
  local hundred = fn.curry_kwd(comp, {factor = 10})
  it("can curry the factor", function()
    assert.is_equal(101, hundred{offset = 1})
  end)
  it("can override", function()
    assert.is_equal(202, hundred{factor=20, offset = 2})
  end)
end)
