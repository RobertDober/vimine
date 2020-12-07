require'tools.line_chunk'
-- local dbg = require("debugger")
-- -- Consider enabling auto_where to make stepping through code easier to follow.
-- dbg.auto_where = 2

local function assert_chunk(chunk, content, startpos, endpos)
   assert.is_equal(content, chunk.content()) 
   if startpos then
     assert.is_equal(startpos, chunk.startpos())
     local endpos = endpos or startpos + #content - 1
     assert.is_equal(endpos, chunk.endpos())
   end
end

describe("LineChunk", function()
  describe("plain vanilla #wip", function()
    local line_chunk = LineChunk({content = "alpha", start = 4})
    it("has it's elements", function()
      assert_chunk(line_chunk, "alpha", 4, 8)
    end)
    it("cannot be changed", function()
      assert.has_error(function()
        line_chunk.content = ""
      end, "LineChunk instances are immutable")
    end)
  end)
  describe("constructed from match", function()
    it("has it's elements", function()
      local line_chunk = LineChunk{content = "alpha", matching = "%f[l](%w+)"}
      assert_chunk(line_chunk, "lpha", 2)
    end)
    it("can be empty", function()
      local line_chunk = LineChunk{content = "alpha", matching = "%f[x](%w+)"}
      assert_chunk(line_chunk, "", 0, 0)
    end)
  end)
  describe("copy with adjusted positions", function()
    local original = LineChunk{content = "alpha", start = 4}
    it("will adjust immutably #wip", function()
      local new = original.adjust_positions(1)
      assert_chunk(original, "alpha", 4)
      assert_chunk(new, "alpha", 5)
    end)
  end)
end)
