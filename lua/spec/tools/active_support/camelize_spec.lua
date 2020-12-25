-- local dbg = require("debugger")
-- dbg.auto_where = 2
local AS = require 'tools.active_support'
local R = require'spec.helpers.random'

describe("camelize", function()
  local function assert_upcased(value)
    local expected = string.upper(string.sub(value, 1, 1)) .. string.sub(value, 2)
    assert.is_equal(expected, AS.camelize(value))
  end

  local function assert_changes(value, expected)
    assert.is_equal(expected, AS.camelize(value))
  end

  context("nothing to do", function()
    it("behaves like id on empty", function()
      assert_upcased("")
    end)
    context("does not change lower case words w/o underlines", function()
      local input
      for j in R.random_words(R.lower_case .. R.digits, 40) do
        it(j .. "is idempotent", function()
          assert_upcased(j)
        end)
      end
    end)
    context("some special cases", function()
      it("or digits", function()
        assert_upcased("12")
      end)
    end)
  end)

  context("changing", function()
    context("some special cases", function()
      for j in R.random_words(" _" .. R.digits, 20, 20) do
        it("replaces all _", function()
          assert_changes(j, string.gsub(j, "_", ""))
        end)
      end
    end)

    it("a simple case", function()
      assert_changes("a_b", "AB")
    end)

    it("a more complicated case", function()
      assert_changes("alpha_beta42_g", "AlphaBeta42G")
    end)
  end)

end)

