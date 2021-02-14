-- local dbg = require("debugger")
-- dbg.auto_where = 2
local stub_vim = require'spec.helpers.stub_vim'.stub_vim

local execute_lines = require'selection_command'.execute_lines
local api = require'nvimapi'

local get_selection = require'context'.get_selection

describe("around selected lines", function()
  stub_vim{lines = {
    "# comment",
    "",
    "class Outer",
    "  module Inner",
    "    content",
    "  end",
    "end" },
    selection = {{4,1}, {6, 8}}} -- N.B. colums are not important in this context

  context("rubocop", function()
    execute_lines('rubocop', 'some/cop')
    expected_buffer = {
    "# comment",
    "",
    "class Outer",
    "  # rubocop:disable some/cop", 
    "  module Inner",
    "    content",
    "  end",
    "  # rubocop:enable some/cop", 
    "end" },
    it('will change the buffer', function()
      assert.are.same(expected_buffer, api.buffer())
    end)
  end)
end)
