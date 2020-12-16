-- local dbg = require("debugger")
-- dbg.auto_where = 2
local chunk = require'tools.string'.chunk

local subject
local function set_subject(str, spos, epos)
  subject = chunk(str, spos, epos)
end

local function assert_chunk_is(string, startpos, endpos, chunk)
  local chunk = chunk or string
  it("has the correct string", function()
    assert.is_equal(string, subject.string())
  end)
  it("has the correct starting positiion", function()
    assert.is_equal(startpos, subject.startpos())
  end)
  it("has the correct end position", function()
    assert.is_equal(endpos, subject.endpos())
  end)
  it("has the correct chunk", function()
    assert.is_equal(chunk, subject.chunk())
  end)
  it("has a nice representation", function()
    assert.are.same({str = string, spos = startpos, epos = endpos, chunk = chunk}, subject:to_s())
  end)
end

local function assert_parts(pfx, sfx)
  local pfx = pfx or ""
  local sfx = sfx or ""
  it("has correct prefix", function()
    assert.is_equal(pfx, subject.prefix())
  end)
  it("has correct suffix", function()
    assert.is_equal(sfx, subject.suffix())
  end)
end

describe("chunks", function()
  describe("empty", function()
    set_subject("")
    assert_chunk_is("", 1, 0)
    assert_parts()
  end)

  describe("default positions", function()
    set_subject("subject")
    assert_chunk_is("subject", 1, 7)
    assert_parts()
    it("hence replace replaces all", function()
      assert.is_equal("new", subject.replace("new").string())
      assert.is_equal("subject", subject.string())
    end)
    describe("delete", function()
      local deleted = subject.delete().string()
      set_subject(deleted)
      assert_chunk_is("", 1, 0, "")
    end)
  end)

  describe("parts", function()
    set_subject("abcdef", 2, 4)
    assert_chunk_is("abcdef", 2, 4, "bcd")
    assert_parts("a", "ef")
  end)

end)
