-- local dbg = require("debugger")
-- dbg.auto_where = 2
local stub_vim = require'spec.helpers.stub_vim'.stub_vim

local execute = require'selection_command'.execute
local api = require'nvimapi'

local get_selection = require'context'.get_selection

describe("sort a list", function()
  --                 0....+....1....+....2.
  stub_vim{lines = {"prefix ['y', 'z', 'x'] suffix"}, selection = {{1, 20}, {1, 8}}} -- N.B. order is not important for cols, index 0 based
  local selection = get_selection()[1]
  it("will find the correct selection", function()
    assert.is_equal(1, selection.lnb)
    assert.is_equal("'y', 'z', 'x'", selection.chunk.chunk())
  end)

  describe("sort it", function()
    execute('sort', ', ')
    it("will change it", function()
      assert.is_equal("prefix ['x', 'y', 'z'] suffix", api.line_at(1))
    end)

    
  end)
end)
