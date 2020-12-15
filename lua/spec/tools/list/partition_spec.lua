local partition = require'tools.list'.partition


describe("partition", function()
  describe("an empty", function()
    local left, middle, right = partition({}, 1, 2) 
    it("ignores indices", function()
      assert.are.same({}, left)
      assert.are.same({}, middle)
      assert.are.same({}, right)
    end)
  end)

  describe("general cases", function()
    local subject = {"one", "two", "three"}
    describe("left bound", function()
      local left, middle, right = partition(subject, 1, 2)
      it("partitions", function()
        assert.are.same({}, left)
        assert.are.same({"one", "two"}, middle)
        assert.are.same({"three"}, right)
      end)
    end)
    describe("middle", function()
      local left, middle, right = partition(subject, 2, 2)
      it("partitions", function()
        assert.are.same({"one"}, left)
        assert.are.same({"two"}, middle)
        assert.are.same({"three"}, right)
      end)
    end)
    describe("right bound", function()
      local left, middle, right = partition(subject, 2, 3)
      it("partitions", function()
        assert.are.same({"one"}, left)
        assert.are.same({"two", "three"}, middle)
        assert.are.same({}, right)
      end)
    end)
  end)

  describe("fault tolerance #wip", function()
    local left, middle, right = partition(subject, 4, 4)
      assert.are.same({}, left)
      assert.are.same({}, middle)
      assert.are.same({}, right)
  end)
end)