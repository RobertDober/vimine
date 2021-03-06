-- local dbg = require("debugger")
-- dbg.auto_where = 2
local stub_vim = require'spec.helpers.stub_vim'.stub_vim
local complete = require'cccomplete'.complete
local api = require'nvimapi'
local r = require'spec.helpers.random'

insulate("default completion", function()
  stub_vim{lines = {"", "# a comment", ""}, cursor = {2, 3}, ft = "elixir"}
  complete()
  it("has added and modified the lines", function()
    assert.are.same({"", "# a comment do", "  ", "end", ""}, api.lines(1, 5))
  end)
end)

insulate("first pipe", function()
  stub_vim{lines = {"  hello >"}, cursor = {1, 999}, ft = "elixir"}
  complete()
  it("has added a pipe", function()
    assert.are.same({"  hello", "  |> "}, api.lines(1, 999))
    assert.are.same({2, 999}, api.cursor())
  end)
end)

insulate("general case", function()
  local now = r.random_string("time_")
  local time_command = 'strftime("%F %T", localtime())' 
  stub_vim{lines = {"  hello >", "it's now %datetime"}, cursor = {2, 999}, ft = "elixir", evaluation = {time_command, now}}
  complete()
  it("expands the %datetime word #wip", function()
    assert.are.same({"  hello >", "it's now " .. now}, api.buffer())
    assert.are.same({2, 999}, api.cursor())
  end)
end)

insulate("regression #1, iex> cccompletion", function()
  stub_vim{lines = {"  hello >", "    iex>"}, cursor = {2, 100}, ft = "elixir"}
  complete()
  it("does not yet add another line", function()
    assert.are.same({"  hello >", "    iex(0)> "}, api.buffer())
    assert.are.same({2, 999}, api.cursor())
  end)
end)

insulate("implementation #3 doc and moduledoc", function()
  context("doc", function()
    stub_vim{lines = {"  hello >", "    doc"}, cursor = {2, 100}, ft = "elixir"}
    complete()
    it("does not yet add another line", function()
      assert.are.same({"  hello >", '    @doc """', '    ', '    """'}, api.buffer())
      assert.are.same({3, 999}, api.cursor())
    end)
  end)
  context("moduledoc", function()
    stub_vim{lines = {"  hello >", "    moduledoc"}, cursor = {2, 100}, ft = "elixir"}
    complete()
    it("does not yet add another line", function()
      assert.are.same({"  hello >", '    @moduledoc """', '    ', '    """'}, api.buffer())
      assert.are.same({3, 999}, api.cursor())
    end)
  end)
end)

