-- local dbg = require("debugger")
-- -- Consider enabling auto_where to make stepping through code easier to follow.
-- dbg.auto_where = 2

local sm = require "tools.state_machine".state_machine

describe("SM", function()
  local function count_bs(_line, match, acc)
    return acc + match
  end
  local function back_to_start(_, _, acc)
    return acc, "start"
  end
  
  local state_machine = sm{
    states = {
      start = {
        {"^a", "state_a"}
      },
      state_a = {
        {"^b %d+", count_bs},
        {".*", back_to_start}
      }
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

  describe("still no trigger → no action #wip", function()
    local lines = {"b 12", "a", " "}
    it("returns the acc", function()
      assert.is_equal(0, state_machine(lines, 0))
    end)
  end)
end)
