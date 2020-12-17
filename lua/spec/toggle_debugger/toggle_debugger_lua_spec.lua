-- local dbg = require("debugger")
-- dbg.auto_where = 2
local stub_vim = require'spec.helpers.stub_vim'.stub_vim
local api = require'nvimapi'

local buffer = {
  "-- some comment",
  "local x = require'a.lib'.x",
  "",
  "local function xxx()",
  "   dbg()",
  "end"
}

stub_vim{ cursor = {3, 4}, lines = buffer, option = {"filetype", "lua"} }

local toggle = require 'toggle_debugger.general'.toggle_debugger

describe("activating the debugger without the header", function()
  toggle()

  it("inserted the lines", function()
    assert.are.same({'local dbg = require("debugger")', 'dbg.auto_where = 2', "-- some comment"}, api.lines(1, 3))
  end)
  it("and it updated the cursor", function()
    assert.are.same({5, 999}, api.cursor())
  end)
  it("writes the modified buffer", function()
    assert.are.same({"write"}, vim.api._executed_commands())
    
  end)
end)

describe("commenting the header", function()
  toggle()

  it("commented the lines", function()
    assert.are.same({'-- local dbg = require("debugger")', '-- dbg.auto_where = 2', "-- some comment"}, api.lines(1, 3))
  end)
  it("and it updated the cursor", function()
    assert.are.same({5, 999}, api.cursor())
  end)
  it("and it removed the breakpoints", function()
    assert.are.same({"write", "g/^\\s*dbg()/d", "write"}, vim.api._executed_commands())
  end)
end)

describe("uncommenting the header", function()
  toggle()

  it("commented the lines", function()
    assert.are.same({'local dbg = require("debugger")', 'dbg.auto_where = 2', "-- some comment"}, api.lines(1, 3))
  end)
  it("and it updated the cursor", function()
    assert.are.same({5, 999}, api.cursor())
  end)
  it("and it did not remove the breakpoints again", function()
    assert.are.same({"write", "g/^\\s*dbg()/d", "write", "write"}, vim.api._executed_commands())
  end)
end)
