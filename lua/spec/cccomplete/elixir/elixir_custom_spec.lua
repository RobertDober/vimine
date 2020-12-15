-- local dbg = require("debugger")
-- dbg.auto_where = 2
local elixir = require'cccomplete.elixir'()

local _ctxt
local function line(value)
  _ctxt = {line = value}
end

local function subject()
  return elixir.complete(_ctxt)
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
    it_behaves_like{lines = {_ctxt.line, "   |> "}}
  end)
  describe("a docstring", function()
    line('  @doc """')
    it_behaves_like{lines = {_ctxt.line, '  ', '  """'}}
  end)
  describe("another docstring", function()
    line('  @moduledoc """')
    it_behaves_like{lines = {_ctxt.line, '  ', '  """'}}
  end)
end)

describe("a docstring", function()
  line('  @doc """')
  it_behaves_like{lines = {_ctxt.line, '  ', '  """'}}
end)
