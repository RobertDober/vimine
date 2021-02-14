-- local dbg = require("debugger")
-- dbg.auto_where = 2
local stub_vim = require'spec.helpers.stub_vim'.stub_vim
local api = require'nvimapi'


describe("api get_selected_lines", function()
  stub_vim{lines = {
    "# comment",
    "",
    "class Outer",
    "  module Inner",
    "    content",
    "  end",
    "end" },
    selection = {{4,1}, {6, 1}}} -- N.B. colums are not important in this context

    expected_selection = {
      "  module Inner",
      "    content",
      "  end"}

      local fl, ll, content = api.get_selected_lines()

      it("has correct first line", function()
        assert.is_equal(4, fl)
      end)

      it("has correct last line", function()
        assert.is_equal(6, ll)
      end)

      it('has the correct selected lines', function()
        assert.are.same(expected_selection, content)
      end)
    end)

