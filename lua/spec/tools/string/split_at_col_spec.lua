-- local dbg = require("debugger")
-- dbg.auto_where = 2
local split_at_col = require'tools.string'.split_at_col

context("no splits", function()
  local function it_does_not_split(line, col)
    it("does not split line: " .. line .. " at " .. col, function()
      local a, b, c = split_at_col(line, col)
      assert.are.same({"", line, ""}, {a, b, c})
    end)
  end

  describe("no match, empty, line, empty", function()
    --             0....+....1....+....2....+
    local input = " abc('def') { :sym, 42 }"
    it_does_not_split(input, 4)
    it_does_not_split(input, 12)
    it_does_not_split(input, 32)
  end)

  describe("whitespace", function()
    local input = "  "
    it_does_not_split(input, 0)
    it_does_not_split(input, 2)
  end)

  describe("alnum", function()
    local input = "alpha42"
    it_does_not_split(input, 0)
    it_does_not_split(input, 1)
  end)
end)

context("splits", function()

  local function it_splits(line, col, ...)
    local expected = {...}
    it("splits line: " .. line .. " at " .. col, function()
      local a, b, c = split_at_col(line, col)
      assert.are.same(expected, {a, b, c})
    end)
  end

  --            0....+....1....+
  local line = '  LHS whitespace'
  it_splits(line, 0, '', '  ', 'LHS whitespace')
  it_splits(line, 2, '  ', 'LHS', ' whitespace')
  it_splits(line, 4, '  ', 'LHS', ' whitespace')
  it_splits(line, 4, '  ', 'LHS', ' whitespace')
  it_splits(line, 5, '  LHS', ' ', 'whitespace')
  it_splits(line, 6, '  LHS ', 'whitespace', '')
  
  -- describe('ruby specific', function()
  --   --            0....+....1....+....2....+.
  --   local line = ' some_call("hello", :world)'
  --   it_splits(line,
  -- end)
end)
