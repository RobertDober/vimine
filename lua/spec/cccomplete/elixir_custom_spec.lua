local elixir = require'cccomplete.elixir'()
-- local dbg = require("debugger")
-- -- Consider enabling auto_where to make stepping through code easier to follow.
-- dbg.auto_where = 2

local _line
local function line(value)
  _line = value
end

local function subject()
  return elixir.complete(_line)
end

local function it_behaves_like(opts)
  local result = subject()
  it("has the correct completion", function()
    assert.are.same(opts.lines, result.lines)
  end)
  it("has the correct offset", function()
    assert.is_equal(opts.offset or 1, result.offset)
  end)
  it("has the correct col", function()
    assert.is_equal(opts.col or 999, result.col)
  end)
end

describe("elixir", function()
  describe("starting a pipeline", function()
    line("  some code >")
    it_behaves_like{lines = {"  some code", "  |> "}}
  end)
  describe("continuing a pipeline", function()
    line("   |> some_more(:code)")
    it_behaves_like{lines = {_line, "   |> "}}
  end)
  describe("a docstring", function()
    line('  @doc """')
    it_behaves_like{lines = {_line, '  ', '  """'}}
  end)
  describe("another docstring", function()
    line('  @moduledoc """')
    it_behaves_like{lines = {_line, '  ', '  """'}}
  end)
end)

  describe("a docstring", function()
    line('  @doc """')
    it_behaves_like{lines = {_line, '  ', '  """'}}
  end)
