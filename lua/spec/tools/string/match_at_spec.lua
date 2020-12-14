local match_at = require'tools.string'.match_at

local subject
local function set_subject(str, pos, pattern)
  local pattern = pattern or "[%w_]+"
  subject = match_at(str, pos, pattern)
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
end

describe("no match", function()
  set_subject("a   b", 2)
  assert_chunk_is("a   b", 2, 1, "")
end)

describe("a default match", function()
  --          0....+....1..
  set_subject("hello :world", 9)
  assert_chunk_is("hello :world", 8, 12, "world") 
end)
