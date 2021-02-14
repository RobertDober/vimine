-- local dbg = require("debugger")
-- dbg.auto_where = 2

local cvcomplete = require'cvcomplete/cvcompleter'
local fn = require'tools.fn'

describe('ruby', function()
  local complete = fn.curry_at(cvcomplete, fn.free, 'undefined filetype J9awsz')

  context('no match → nil', function()
    it('behaves as promised', function()
      assert.is_nil(complete('azdeziuhui'))
    end)
  end)

  context('sort a list', function()
    local sel = 'bc, aa, ba, df'
    it('kinda sorts it all out', function()
      assert.is_equal('aa, ba, bc, df', complete(sel))
    end)
  end)

  context('tuples are not sorted, but switched', function()
    it('is true for unsorted tuples', function()
      assert.is_equal('b, a', complete('a, b'))
    end)
    it('as it is true for sorted tuples', function()
      assert.is_equal('a, b', complete('b, a'))
    end)
  end)
end)
