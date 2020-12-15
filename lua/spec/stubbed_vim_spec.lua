-- local dbg = require("debugger")
-- dbg.auto_where = 2

local stub = require'spec.helpers.stub_vim'
stub(function(stubber)
  stubber.cursor(2,3)
  stubber.lines("alpha", "beta", "gamma")
  stubber.option("ft", "elixir")
  stubber.command('expand("%:t")', "filename")
  stubber.command('expand("%")', "/full/path")
end)

local context1 = require'context'.context

describe("vim", function()
  context("explicitly stubbed", function()
    it("cursor has been stubbed", function()
      assert.are.same({2, 3}, vim.api.nvim_win_get_cursor(0))
    end)
    it("lines have been stubbed", function()
      assert.is_equal("beta", vim.api.nvim_get_current_line())
      assert.are.same({"alpha", "beta", "gamma"}, vim.api.nvim_buf_get_lines(0,0,3,false))
    end)
    it("options have been stubbed", function()
      assert.is_equal("elixir", vim.api.nvim_buf_get_option(0, "ft"))
    end)
    it("commands have been stubbed", function()
      assert.is_equal("filename", vim.api.nvim_eval('expand("%:t")'))
      assert.is_equal("/full/path", vim.api.nvim_eval('expand("%")'))
    end)
  end)
  context("implicitly stubbed", function()
    it("has a fake inspect", function()
      assert.is_equal("42", vim.inspect(42))
    end)
  end)

end)

describe("context accesses stubbed data", function()
  local ctxt = context1()
  it("renders correct line", function()
    assert.is_equal("beta", ctxt.line)
  end)
  it("renders the correct pre_line", function()
    assert.is_equal("alpha", ctxt.pre_line)
  end)
  it("renders the correct post_line", function()
    assert.is_equal("gamma", ctxt.post_line)
  end)

end)
