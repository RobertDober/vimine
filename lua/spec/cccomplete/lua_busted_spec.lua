local lua = require('cccomplete.lua')()
describe("lua", function()

  local fn_suffix = ", function()"
  function suffixed(str)
    return str .. fn_suffix
  end

  describe("complete busted function", function()
    local function check_busted_completion(name, input, expected)
      local indent = string.match(input, "^%s*")
      local completion = lua.complete(input)

      describe(name, function()
        it("has the correct lines", function()
          assert.are.same({indent .. expected, indent .. "  ", indent .. "end)"}, completion.lines)
        end)
        it("has the correct offset", function()
          assert.is_equal(1, completion.offset)
        end)
        it("has the correct col", function()
          assert.is_equal(999, completion.col)
        end)
      end)
    end

    check_busted_completion("before_each", "before_each(", "before_each(function()")
    check_busted_completion("describe", "describe('hello'", suffixed("describe('hello'"))
    check_busted_completion("describe", "describe('hello', ", suffixed("describe('hello'"))
    check_busted_completion("expose", "expose(\"something\"", suffixed("expose(\"something\""))
    check_busted_completion("insulate", "insulate(hello", suffixed("insulate(hello"))
    check_busted_completion("it", "it(is Monty Python's Flying Circus", suffixed("it(is Monty Python's Flying Circus"))
    check_busted_completion("it with closing )", "it(is Monty Python's Flying Circus)", suffixed("it(is Monty Python's Flying Circus"))
    check_busted_completion("it without opening (", "it is Monty Python's Flying Circus)", suffixed("it(is Monty Python's Flying Circus"))
    check_busted_completion("setup", "setup(", "setup(function()")
    check_busted_completion("teardown", "  teardown", "teardown(function()")
    check_busted_completion("no multiple function", "   describe(\"hello\", function()", suffixed('describe("hello"'))

  end)
end)

