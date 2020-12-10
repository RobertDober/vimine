local readonly = require'tools.list'.readonly

describe("readonly", function()
  local t = readonly{a=1, b=2}
  it("can not be extended", function()
    assert.has_error(function()
      t.c = 3
    end)
  end)
  it("cannot be modified either", function()
    assert.has_error(function()
      t.a = 2
    end)
  end)
end)
