-- local dbg = require("debugger")
-- dbg.auto_where = 2

local complete = require'cicomplete/general'

local subject
local function set_subject(value)
  subject = value
end
local function complete_it()
  return complete(subject)
end
  
describe('squashing spaces', function()
  it('squashes a left side space', function()
    set_subject{prefix='a ', char=' ', suffix='b'}
    assert.is_equal('a b', complete_it())
  end)
  it('squashes a right side space', function()
    set_subject{prefix='a', char=' ', suffix=' b'}
    assert.is_equal('a b', complete_it())
  end)
  it('squashes spaces on both sides', function()
    set_subject{prefix='a  ', char=' ', suffix=' b'}
    assert.is_equal('a b', complete_it())
  end)
  it('does not squash any spaces if char is no space', function()
    set_subject{prefix='a ', char='x', suffix='  b'}
    assert.is_equal('a x  b', complete_it())
  end)
end)

