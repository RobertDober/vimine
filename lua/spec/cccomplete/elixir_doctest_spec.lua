local elixir = require'cccomplete.elixir'()
-- local dbg = require("debugger")
-- -- Consider enabling auto_where to make stepping through code easier to follow.
-- dbg.auto_where = 2

local subject

local function it_behaves_like_doctest(opts)
  local offset = opts.offset or 1
  local col    = opts.col or 999
  it("has correct lines", function()
    assert.are.same(opts.lines, subject.lines)
  end)
  it("has correct offset", function()
    assert.is_equal(subject.offset, offset)
  end)
  it("has correct col", function()
    assert.is_equal(subject.col, col)
  end)
end

describe("elixir", function()
  describe("unnumbered first line too little indent", function()
    local line = "   iex> some code"
    subject = elixir.complete(line)
    it_behaves_like_doctest{lines = {"   iex> some code do", "     ", "   end"}}
  end)
  describe("unnumbered first line", function()
    local line = "    iex> some code"
    subject = elixir.complete(line)
    it_behaves_like_doctest{lines = {"    iex(0)> some code", "    ...(0)> "}}
  end)
  describe("unnumbered continuation line", function()
    local line = "     ...> some code"
    subject = elixir.complete(line)
    it_behaves_like_doctest{lines = {"     ...(0)> some code", "     ...(0)> "}}
  end)
  describe("numbered first line", function()
    local line = "     iex(42)> some code"
    subject = elixir.complete(line)
    it_behaves_like_doctest{lines = {"     iex(42)> some code", "     ...(42)> "}}
  end)
  describe("numbered continuation line", function()
    local line = "      ...(44)> some code"
    subject = elixir.complete(line)
    it_behaves_like_doctest{lines = {"      ...(44)> some code", "      ...(44)> "}}
  end)
end)
