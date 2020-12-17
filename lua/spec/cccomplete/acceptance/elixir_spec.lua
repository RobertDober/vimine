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
  it("expands the %datetime word", function()
    assert.are.same({"  hello >", "it's now " .. now}, api.lines(1, 999))
    assert.are.same({2, 999}, api.cursor())
  end)
end)
