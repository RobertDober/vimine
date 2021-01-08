-- local dbg = require("debugger")
-- dbg.auto_where = 2
local stub_vim = require'spec.helpers.stub_vim'.stub_vim
local complete = require'cccomplete'.complete
local api = require'nvimapi'
local r = require'spec.helpers.random'

insulate("module in first line lib file", function()
  stub_vim{lines = {"module", "# a comment", ""}, cursor = {1, 3}, ft = "elixir", path = "something/lib/lab42/main/x.ex"}
  complete()
  it("has added and modified the lines", function()
    assert.are.same({"defmodule Lab42.Main.X do", "  ", "end", "# a comment"}, api.lines(1, 4))
  end)
  it("has the correct offset", function()
    assert.are.same({2, 999}, api.cursor())
  end)
end)
