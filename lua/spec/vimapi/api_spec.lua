-- local dbg = require("debugger")
-- dbg.auto_where = 2
local stub = require'spec.helpers.stub_vim'

local api = require'nvimapi'

local slice = require'tools.list'.slice
local r = require'spec.helpers.random'
local full_path = r.random_string("full_path_")
local filetype = r.random_string("filetype_")

local buffer = r.random_strings("line_%n_", 5)
local current = buffer[3]
stub.stub_vim{ cursor = {3, 4}, lines = buffer, evaluation = {'expand("%")', full_path }, option = {"filetype", filetype}, var = {"alpha", 1} }
stub.stubber.var("beta", 2)

describe("Read Access", function()
  it("cursor has correct value", function()
    assert.are.same({3, 4}, api.cursor())
  end)
  it("current_line has correct value", function()
    assert.is_equal(current, api.line())
  end)
  it("general line access", function()
    for i = 1, 5 do
      for j = i, 5 do
        assert.are.same(slice(buffer, i, j), api.lines(i, j))
      end
    end
  end)
  it("specific line access", function()
    for i = 1, 5 do
      assert.is_equal(buffer[i], api.line_at(i))
    end
    assert.is_nil(api.line_at(0))
    assert.is_nil(api.line_at(6))
  end)
  it("option filetype has correct value", function()
    assert.is_equal(filetype, api.option("filetype"))
  end)
  it("evals correcty", function()
    assert.is_equal(full_path, api.eval('expand("%")'))
  end)
  it("accesses the variables", function()
    assert.is_equal(1, api.var("alpha"))
    assert.is_equal(2, api.var("beta"))
  end)
end)
insulate("Write access", function()
  it("can set the cursor", function()
    api.set_cursor({5, 997})
    assert.are.same({5, 997}, api.cursor())
    assert.is_equal(buffer[5], api.line())
  end)
  it("can set the cursor, convinience", function()
    api.set_cursor(4, 998)
    assert.are.same({4, 998}, api.cursor())
    assert.is_equal(buffer[4], api.line())
  end)
  it("can set the cursor, even more convinience", function()
    api.set_cursor(3)
    assert.are.same({3, 999}, api.cursor())
    assert.is_equal(buffer[3], api.line())
  end)
  it("can add some lines", function()
    -- at the beginning
    local line0 = r.random_string("zero")
    local line1 = r.random_string("one")
    api.set_lines(1, 0, {line0})
    assert.are.same({line0, buffer[1]}, api.lines(1, 2))
    -- after the beginning
    api.set_lines(2, 1, {line0})
    assert.are.same({line0, line0, buffer[1]}, api.lines(1, 3))
    -- replacing buffer[1] and buffer[2]
    api.set_lines(3, 4, {line1, line0})
    assert.are.same({line0, line0, line1, line0, buffer[3]}, api.lines(1, 5))
    -- replacing everything
    api.set_lines(1, 999, {line1})
    assert.are.same({line1}, api.lines(1, 5))
    -- inserting at the end
    api.set_lines(2, 1, {line0})
    assert.are.same({line1, line0}, api.lines(1, 5))
  end)
end)

describe("command execution", function()
  it("is recorded by the stub", function()
    local cmd1 = r.random_string("cmd")
    local cmd2 = r.random_string("cmd")
    api.command(cmd1)
    api.command(cmd2)
    assert.are_same({cmd1, cmd2}, vim.api._executed_commands())
  end)
end)

describe("function calls", function()
  it("can call any function", function()
    api.call_function("a", 1, 2)
    assert.are.same({"a", {1, 2}}, vim.api._called()[1])
  end)
  it("can also use the system shortcut", function()
    api.system("echo hello")
    assert.are.same({"system", {"echo hello"}}, vim.api._called()[2])
  end)
end)
