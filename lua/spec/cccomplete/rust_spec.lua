local rust = require'cccomplete.rust'()
local function complete(line)
  return rust.complete({line = line})
end
describe("rust", function()

  describe("complete without do", function()
    -- describe("module", function()
    --   completion = complete("  module X")
    --   it("has the correct lines", function()
    --     assert.are.same({"  module X", "    ", "  end"}, completion.lines)
    --   end)
    --   it("has the correct offset", function()
    --     assert.is_equal(1, completion.offset)
    --   end)
    --   it("has the correct col", function()
    --     assert.is_equal(999, completion.col)
    --   end)
    -- end)

    -- describe("class", function()
    --   completion = complete("class Y")
    --   it("has the correct lines", function()
    --     assert.are.same({"class Y", "  ", "end"}, completion.lines)
    --   end)
    --   it("has the correct offset", function()
    --     assert.is_equal(1, completion.offset)
    --   end)
    --   it("has the correct col", function()
    --     assert.is_equal(999, completion.col)
    --   end)
      
    -- end)
  end)

  describe("complete with {", function()
    describe("any line", function()
      it("adds a {", function()
        completion = complete("  something")
        --               0..               0....+.
        assert.are.same({"  something {" , "      ", "  }"}, completion.lines)
      end)
      it("unless there is one already", function()
        completion = complete("  something {")
        --               0..               0....+.
        assert.are.same({"  something {" , "      ", "  }"}, completion.lines)
      end)
      it("unless there is one already → still reformatting", function()
        completion = complete("  something{  ")
        --               0..               0....+.
        assert.are.same({"  something {" , "      ", "  }"}, completion.lines)
      end)
      it("unless there is one already → still  more reformatting", function()
        completion = complete("  something  {  ")
        --               0..               0....+.
        assert.are.same({"  something {" , "      ", "  }"}, completion.lines)
      end)
      it("also takes care of trailing ws", function()
        completion = complete("  something    ")
        --               0..               0....+.
        assert.are.same({"  something {" , "      ", "  }"}, completion.lines)
      end)
    end)

    describe("fn", function()
      it("behaves like default, if parlist is present", function()
        completion = complete("fn x()")
        assert.are.same({"fn x() {", "    ", "}"}, completion.lines)
      end)
      it("pub too behaves like default, if parlist is present", function()
        completion = complete("    pub fn x()")
        assert.are.same({"    pub fn x() {", "        ", "    }"}, completion.lines)
      end)
      it("adds params if needed tag", function()
        completion = complete("fn x")
        assert.are.same({"fn x() {", "    ", "}"}, completion.lines)
      end)
      it("pub adds params if needed", function()
        completion = complete("    pub fn x")
        assert.are.same({"    pub fn x() {", "        ", "    }"}, completion.lines)
        
      end)
    end)
  end)
end)

