-- local dbg = require("debugger")
-- dbg.auto_where = 2

local stub    = require'spec.helpers.stub_vim'

local context = require'context'.context
--                0....+....1....+....2....+....3....+
local buffer  = {'  a  typical(line, 42) -- or   so'}
stub.stub_vim{cursor={1, 6}, lines = buffer}

local ctxt = context()
describe('cursor related', function()
  it('has a col', function()
    assert.is_equal(6, ctxt.col)
  end)
  it('has a lnb', function()
    assert.is_equal(1, ctxt.lnb)
  end)
  it('has a char', function()
    assert.is_equal('y', ctxt.char)
  end)
  it('has a prefix', function()
    assert.is_equal('  a  t', ctxt.prefix)
  end)
  it('has a suffix', function()
    assert.is_equal('pical(line, 42) -- or   so', ctxt.suffix)
  end)
end)

