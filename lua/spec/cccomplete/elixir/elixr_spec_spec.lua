local elixir = require'cccomplete.elixir'()

local subject

local function complete(...)
  local lines = {...}
  subject = elixir.complete({line = lines[1], post_line = lines[2]})
end

local function expect(...)
  assert.are.same({...}, subject.lines)
end

local function expect_position(offset, col)
  assert.is_equal(offset, subject.offset)
  assert.is_equal(col, subject.col)
end

describe("not a spec", function()
  context("because not a spec line", function()
    it("completes with do", function()
      complete("not a spec", "something")
      expect("not a spec do", "  ", "end")
      expect_position(1, 999)
    end)
  end)
  context("because next line is no function", function()
    it("completes with do", function()
      complete("      spec", "something")
      expect(  "      spec do", "        ", "      end")
      expect_position(1, 999)
    end)
  end)
end)

describe("a spec", function()
  context("because of a def", function()
    it("completes with @spec <name of def>", function()
      complete(" spec", "  def insert")
      expect("  @spec insert(")
      expect_position(0, 999)
    end)
  end)
  
  context("because of a defp", function()
    it("completes with @spec <name of def>", function()
      complete(" spec", "  defp insert")
      expect("  @spec insert(")
      expect_position(0, 999)
    end)
  end)
end)
