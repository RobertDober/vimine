-- local dbg = require("debugger")
-- -- Consider enabling auto_where to make stepping through code easier to follow.
-- dbg.auto_where = 2
local renumber = require'filters.iex_renumber'

local input

describe("IEX Renumber", function()
  context("no iex doctests" , function()
    input = {"line 1", "line 2"}
    it("does not change the input", function()
      expected = input
      assert.are.same(expected, renumber(input))
    end)
  end)
  context("a real world example", function()
    input = {
      "defmodule",
      "",
      " iex",
      "    iex(12)> alpha",
      "    ...> beta",
      "",
      "    ...> gamma",
      "    ...> delta"
    }
    it("complies", function()
      local expected = {
        "defmodule",
        "",
        " iex",
        "    iex(0)> alpha",
        "    ...(0)> beta",
        "",
        "    iex(1)> gamma",
        "    ...(1)> delta"
      }
      assert.are.same(expected, renumber(input))
    end)

  end)
end)
