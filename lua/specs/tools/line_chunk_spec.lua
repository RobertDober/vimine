require'tools.line_chunk'

describe("LineChunk", function()
  describe("plain vanilla", function()
    local line_chunk = LineChunk:new{content = "alpha", start = 4}
    it("has it's elements", function()
      assert.is_equal(line_chunk.content, "alpha")
      assert.is_equal(line_chunk.startpos, 4)
      assert.is_equal(line_chunk.endpos, 8)
    end)
    it("cannot be changed", function()
      assert.has_error(function()
        line_chunk.content = ""
      end, "LineChunk instances are immutable")
    end)
  end)
  describe("constructed from match", function()
    it("has it's elements", function()
      local line_chunk = LineChunk:new{content = "alpha", matching = "%f[l](%w+)"}
      assert.is_equal(line_chunk.content, "lpha")
      assert.is_equal(line_chunk.startpos, 2)
      assert.is_equal(line_chunk.endpos, 5)
    end)
    it("can be empty", function()
      local line_chunk = LineChunk:new{content = "alpha", matching = "%f[x](%w+)"}
      assert.is_equal(line_chunk.content, "")
      assert.is_equal(line_chunk.startpos, 0)
      assert.is_equal(line_chunk.endpos, 0)
      
    end)
  end)
end)
