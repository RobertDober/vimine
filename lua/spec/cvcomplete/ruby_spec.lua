-- local dbg = require("debugger")
-- dbg.auto_where = 2

local cvcomplete = require'cvcomplete/cvcompleter'
local fn = require'tools.fn'

describe('ruby', function()
  local rbcomplete = fn.curry_at(cvcomplete, fn.free, 'ruby')

  context('symbol → quoted strings', function()
    it('changes a symbol to a single quoted string', function()
      assert.is_equal("'beta'", rbcomplete(':beta', 'ruby'))
    end)
    it('changes a single quoted string to a double quoted string', function()
      assert.is_equal('"beta"', rbcomplete("'beta'", 'ruby'))
    end)
    it('changes a double quoted string to a symvol', function()
      assert.is_equal(':beta', rbcomplete('"beta"', 'ruby'))
    end)
  end)

  context('no match → nil (which does the right thing with api.set_selected_part', function()
    it('returns nil, as promised', function()
      assert.is_nil(rbcomplete('  xedi42'))
    end)
  end)
end)
