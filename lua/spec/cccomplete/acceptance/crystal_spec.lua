-- local dbg = require("debugger")
-- dbg.auto_where = 2
local stub_vim = require'spec.helpers.stub_vim'.stub_vim
local complete = require'cccomplete'.complete
local api = require'nvimapi'
local r = require'spec.helpers.random'

insulate("default completion", function()
  stub_vim{lines = {"", "# a comment", ""}, cursor = {2, 3}, ft = "elixir"}
  complete()
  it("has added and modified the lines #wip", function()
    assert.are.same({"", "# a comment do", "  ", "end", ""}, api.lines(1, 5))
  end)
end)

context("no do cases", function()
  describe("struct", function()
    stub_vim{lines = {"  hello >", "  struct A"}, cursor = {2, 999}, ft = "crystal"}
    complete()
    it("expands", function()
      assert.are.same({"  hello >", "  struct A", "    ", "  end"}, api.buffer())
      assert.are.same({3, 999}, api.cursor())
    end)
  end)

end)
