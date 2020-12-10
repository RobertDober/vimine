require'tools.line'
-- local dbg = require("debugger")
-- -- Consider enabling auto_where to make stepping through code easier to follow.
-- dbg.auto_where = 2

local function assert_line_chunk(name, line_chunk, content, startpos, endpos)
  it(name, function()
      assert.is_equal(line_chunk.content(), content)
      assert.is(line_chunk.startpos(), startpos)
      assert.is_equal(line_chunk.endpos(), endpos)
  end)
end

describe("Line", function()
  local line = Line{parts={" ", "alpha ", "middle", " omega"}}

  describe("from parts", function()
    it("has 4 chunks", function()
      assert.is_equal(#line.chunks(), 4)
    end)
    it("has it's cursor at the beginning ", function()
      assert.is_equal(line.cursor(), 1) 
      assert.is_equal(line.current().content(), " ")
    end)
    it("can be constructed with a different cursor position", function()
      different = Line{parts = {"a", "b"}, cursor = 2}
      assert.is_equal(different.cursor(), 2)
      assert.is_equal(different:current().content(), "b")
    end)
    assert_line_chunk("first", line.chunks()[1], " ", 1, 1)
    assert_line_chunk("second", line.chunks()[2], "alpha ", 2, 7)
    assert_line_chunk("third", line.chunks()[3], "middle", 8, 13)
    assert_line_chunk("fourth", line.chunks()[4], " omega", 14, 19)
  end)

  describe("immutability", function()
    local original = Line{parts = {}}
    it("cannot be changed", function()
      assert.has_error(function()
        original.chunks1 = {}
      end, "Line instances are immutable")
    end)
  end)
  describe("replacements", function()
    local source = Line{parts = {"alpha", "beta", "gamma"}, cursor=2}
    describe("returns a new instance ", function()
      local target = source.replace_current("***")
      describe("it has not changed source", function()
        assert_line_chunk("second", source.chunks()[2], "beta", 6, 9)
        assert_line_chunk("third", source.chunks()[3], "gamma", 10, 14)
      end)
      describe("target has updated all values #wip", function()
        assert_line_chunk("second", target.chunks()[2], "***", 6, 8)
        assert_line_chunk("third", target.chunks()[3], "gamma", 9, 13)
      end)
    end)
  end)

  describe("error case, cannot find parts", function()
    it("will croak", function()
      assert.has_error(function()
        Line{}
      end, "Missing arguments to construct a Line: (parts)")
    end)
  end)
end)
