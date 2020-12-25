-- local dbg = require("debugger")
-- dbg.auto_where = 2
local stub_vim = require'spec.helpers.stub_vim'.stub_vim
local complete = require'cccomplete'.complete
local api = require'nvimapi'
local r = require'spec.helpers.random'

insulate("module completion", function()
  stub_vim{lines = {"module", "# a comment"}, cursor = {1, 3}, ft = "elixir", path = "test/amodule/hello_test.exs"}
  complete()
  it("has added and modified the lines", function()
    assert.are.same({
      "defmodule Test.Amodule.HelloTest do",
      "  use ExUnit.Case",
      "",
      "  ",
      "end"}, api.lines(1, 5))
    assert.are.same({4, 999}, api.cursor())
  end)
end)

