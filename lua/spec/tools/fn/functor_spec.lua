-- local dbg = require("debugger")
-- dbg.auto_where = 2
local F = require'tools.functors'

describe("equals functor", function()
  describe("string equality", function()
    local str_equal = F.equals("hello")
    it("might be equal", function()
        assert.is_true(str_equal("hello"))
    end)
    it("or not", function()
        assert.is_false(str_equal("Hello"))
    end)
  end)
end)

