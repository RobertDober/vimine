-- local dbg = require("debugger")
-- -- Consider enabling auto_where to make stepping through code easier to follow.
-- dbg.auto_where = 2

local sm = require "tools.state_machine".state_machine

describe("SM", function()
  describe("simple triggers", function()
    local function count_bs(_line, match, acc)
      return acc + match
    end
    local function back_to_start(_, _, acc)
      return acc, "start"
    end

    local state_machine = sm{
      start = {
        {"^a", "state_a"}
      },
      state_a = {
        {"^b %d+", count_bs},
        {".*", back_to_start}
      }
    }

    describe("empty run → acc", function()
      local lines = {}
      it("returns the acc", function()
        assert.is_equal(state_machine(lines, 0), 0)
      end)
    end)

    describe("no trigger → no action", function()
      local lines = {"b 12", ""}
      it("returns the acc", function()
        assert.is_equal(0, state_machine(lines, 0))
      end)
    end)

    describe("still no trigger → no action", function()
      local lines = {"b 12", "a", " "}
      it("returns the acc", function()
        assert.is_equal(0, state_machine(lines, 0))
      end)
    end)

    describe("trigger a and go back", function()
      local lines = {"a", "c"}
      it("returns the acc", function()
        assert.is_equal(2, state_machine(lines, 2))
      end)
    end)
  end)

  describe("multipattern triggers", function()
    local keywords = { "alpha", "beta" }
    local openers = { "[(]", "[[]" }
    local closers = { "[)]", "[]]" }

    local function count_keyword(_, _, acc)
      acc.count = acc.count + 1
      return acc
    end
    local function disable_count(_, match, acc)
      local closing =  { ["("] = ")", ["["] = "]" }
      acc.closer = closing[match]
      return acc, "ignore"
    end
    local function maybe_enable_count(_, match, acc)
      if acc.closer == match then
        acc.closer = ""
        return acc, "start"
      else
        error("Illegal closer: " .. mactch .. ", expected: " .. acc.closer)
      end
    end

    local state_machine = sm{
      start = {
        {keywords, count_keyword},
        {openers,  disable_count},
        {closers,  function(_,closer,_) error("unexpected closer " .. closer) end}
      },
      ignore = {
        {closers,  maybe_enable_count},
        {openers,  function(_,closer,_) error("2nd level opener " .. closer) end}
      }
    }
    describe("an uneventful run", function()
      it("returns zero", function()
        assert.are.same({count = 0}, state_machine({"a", "b"}, {count = 0}))
      end)
    end)
  end)

  describe("functional patterns", function()
    local is_odd = function(line)
      return (line + 0) % 2 == 1
    end
    local state_machine = sm{
      start = {
        {is_odd, function(_,_,acc) return acc + 1 end}
      }
    }
    describe("counting oddities", function()
      it("does indeed", function()
        assert.is_equal(2, state_machine({1, 2, 3}, 0))
      end)
    end)
  end)
end)
