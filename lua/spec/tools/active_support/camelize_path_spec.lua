-- local dbg = require("debugger")
-- dbg.auto_where = 2
local AS = require 'tools.active_support'

describe("camelize_path", function()

  local function assert_changes(value, expected)
    assert.is_equal(expected, AS.camelize_path(value))
  end

  it("into .", function()
    assert_changes("a/b/c", "A.B.C")
  end)

  it("some underlines and an extension", function()
    assert_changes("a_b/c_d/x_y.ex", "AB.CD.XY")
  end)
end)
