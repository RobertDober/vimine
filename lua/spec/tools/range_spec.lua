local range=require 'tools.range'

local function it_is_empty(subject)
  it("can be converted into a list", function()
    assert.are.same({}, subject:to_list())
  end)
  it("can be iterated over", function()
    local sum = nil 
    for val in subject:iter() do
      error("must not be called")
    end
    assert.is_nil(sum)
  end)
end

local function it_is_range(subject, low, high, list)
  it("has a low bound", function()
    assert.is_equal(low, subject.low)
  end)
  it("has a high bound", function()
    assert.is_equal(high, subject.high)
  end)
  if list then
    it("can be converted into a list", function()
      assert.are.same(list, subject:to_list())
    end)
  end
end

describe("range", function()
  describe("in its simplest form", function()
    local subject = range(1, 2)
    it_is_range(subject, 1, 2, {1, 2})
    it("can be iterated over", function()
      local sum = 0
      for val in subject:iter() do
        sum = sum + val
      end
      assert.is_equal(3, sum)
    end)
  end)

  describe("intersection", function()
    describe("empty case", function()
      local subject = range(1, 2):intersect(range(3, 4))
      it_is_empty(subject)
    end)

    describe("inner case", function()
      local subject = range(1, 4):intersect(range(2, 3))
      it_is_range(subject, 2, 3)
    end)

    describe("outer case explicit bounds", function()
      local subject = range(2, 3):intersect(1, 4)
      it_is_range(subject, 2, 3)
    end)

    describe("real intersection", function()
      local subject = range(1, 10):intersect(range(8, 11))
      it_is_range(subject, 8, 10, {8, 9, 10})
    end)
  end)

  describe("extensions", function()
    describe("nop case", function()
      local subject = range(1, 10):extend(range(2, 10))
      it_is_range(subject, 1, 10)
    end)
    describe("extend to the left, explicit bounds", function()
      local subject = range(2, 3):extend(1, 2)
      it_is_range(subject, 1, 3)
    end)
    describe("extend to the right", function()
      local subject = range(2, 3):extend(range(2, 10))
      it_is_range(subject, 2, 10)
    end)
    describe("with holes, be aware of elments added in between, explicit bounds", function()
      local subject = range(1, 1):extend(3, 3)
      it_is_range(subject, 1, 3)
    end)
  end)
end)
