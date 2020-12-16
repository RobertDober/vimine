-- local dbg = require("debugger")
-- dbg.auto_where = 2
local stub_vim = require'spec.helpers.stub_vim'.stub_vim
local complete = require'cccomplete'.complete

insulate("default completion", function()
  stub_vim{lines = {"", "# a comment", ""}, cursor = {2, 3}, ft = "elixir"}
  complete()
  it("has added and modified the lines", function()
    assert.are.same({"# a comment do", "  ", "end", ""}, vim.api.nvim_buf_get_lines
  end)

end)
  
