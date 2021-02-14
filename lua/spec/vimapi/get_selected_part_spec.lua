-- local dbg = require("debugger")
-- dbg.auto_where = 2
local stub = require'spec.helpers.stub_vim'

local api = require'nvimapi'

--            0....+....1....+....2....+....3....+....4 
local line = '  alpha("beta", :gamma, 42) # no comment'

stub.stub_vim{lines={line}, selection={{1,2}, {1,6}}, option = {"filetype", "ruby"}}

describe("correct selection", function()
  local sel = api.get_selected_part()
  it("has whole line", function()
    assert.is_equal(line, sel.line)
  end)
  it("has correct selection", function()
    assert.is_equal('alpha', sel.selection)
  end)
  it("has correct begcol", function()
    assert.is_equal(2, sel.begcol)
  end)
  it("has correct endcol", function()
    assert.is_equal(6, sel.endcol)
  end)
  it("can change the selection", function()
    api.set_selected_part("new")
    assert.are.same({'  new("beta", :gamma, 42) # no comment'}, api.buffer())
  end)
  it("can change the selection, passing in the selection", function()
    api.set_selected_part("newest", sel)
    assert.are.same({'  newest("beta", :gamma, 42) # no comment'}, api.buffer())
  end)
  it("is a nop if nil is passed in", function()
    api.set_selected_part(nil, sel)
    assert.are.same({'  newest("beta", :gamma, 42) # no comment'}, api.buffer())
  end)
end)

