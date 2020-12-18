-- local dbg = require("debugger")
-- dbg.auto_where = 2
local stub = require'spec.helpers.stub_vim'
local stub_vim = stub.stub_vim
local stubber = stub.stubber

local complete = require'cccomplete'.complete
local api = require'nvimapi'
local r = require'spec.helpers.random'

describe("%datetime", function()
  stub_vim{lines = {"  hello >", "it's now %datetime", "%date"}, cursor = {2, 999}, ft = "???"}
  local now = r.random_string("time_")
  local time_command = 'strftime("%F %T", localtime())' 
  stubber.evaluation(time_command, now)

  complete()
  it("expands the %datetime word", function()
    assert.are.same({"  hello >", "it's now " .. now, "%date"}, api.buffer())
    assert.are.same({2, 999}, api.cursor())
  end)
end)

insulate("%date", function()
  stub_vim{lines = {"  hello >", "it's now %datetime", "%date"}, cursor = {2, 999}, ft = "???"}
  local now = r.random_string("date_")
  local time_command = 'strftime("%F", localtime())' 
  stubber.evaluation(time_command, now)
  stubber.cursor(3, 999)

  complete()
  it("expands the %date word", function()
    assert.are.same({"  hello >", "it's now %datetime", now}, api.buffer())
    assert.are.same({3, 999}, api.cursor())
  end)
end)

