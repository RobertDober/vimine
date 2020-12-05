local lua = require('cccomplete.lua')()
describe("lua", function()
  -- tests go here

  describe("complete busted function", function()
    local function check_busted_completion(name, input, nocomma)
      local comma
      local input = input
      local completion = lua.complete(input)
      local indent = string.match(input, "^%s*")
      if nocomma then
        comma = "("
        input = string.gsub(input, "[(]?%s*$", "")
      else
        comma = ", "
        input = string.gsub(input, ",%s*$", "")
      end

      describe(name, function()
        it("has the correct lines", function()
          assert.are.same({input .. comma .. "function()", indent .. "  ", indent .. "end)"}, completion.lines)
        end)
        it("has the correct offset", function()
          assert.is_equal(1, completion.offset)
        end)
        it("has the correct col", function()
          assert.is_equal(999, completion.col)
        end)
      end)
    end

    check_busted_completion("before_each", "before_each(", true)
    check_busted_completion("describe", "describe('hello'")
    check_busted_completion("describe #wip", "describe('hello',  ")
    check_busted_completion("expose", "expose(\"something\"")
    check_busted_completion("insulate", "insulate(hello")
    check_busted_completion("it", "it(is Monty Python's Flying Circus")
    check_busted_completion("setup", "setup(", true)
    check_busted_completion("teardown", "teardown", true)
  end)
end)

