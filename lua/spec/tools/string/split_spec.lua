-- local dbg = require("debugger")
-- dbg.auto_where = 2

local split = require "tools.string".split

describe("split", function()
  it("a typical use case", function()
    assert.are.same({"a", "b"}, split("a b"))
  end)
  it("still quite common", function()
    assert.are.same({"a", "b"}, split("a, b", ",%s*"))
  end)

  it("is very useful, this one", function()
    assert.are.same({"a", " ", "b"}, split("a b", ""))
  end)
  
end)
