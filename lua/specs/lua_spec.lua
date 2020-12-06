local lua = require('cccomplete.lua')()
describe("lua", function()

  describe("complete without do", function()
    local function check_function_completion(name, input, fncompleted)
      local fncompleted = fncompleted or input
      local indent = string.match(input, "^%s*")
      local completion = lua.complete(input)
      describe(name, function()
        it("has the correct lines", function()
          assert.are.same({fncompleted, indent .. "  ", indent .. "end"}, completion.lines)
        end)
        it("has the correct offset", function()
          assert.is_equal(1, completion.offset)
        end)
        it("has the correct col", function()
          assert.is_equal(999, completion.col)
        end)
      end)
    end

    check_function_completion("global function with no params #wip", "function X()")
    check_function_completion("global function with no params, parens added", "  function X", "  function X()")
    check_function_completion("local function with params", "  local function hello(world)")
    check_function_completion("local function with params, rparen added", "  local function hello(world", "  local function hello(world)")
    check_function_completion("globally assigned function", "alpha = function()")
    check_function_completion("locally assigned function", "local beta = function(a, b, ...)")
  end)

  describe("complete with do", function()
    describe("any line", function()
      completion = lua.complete("  something")
      it("adds a  do", function()
        assert.are.same({"  something do", "    ", "  end"}, completion.lines)
      end)
    end)
    describe("any line do present", function()
      completion = lua.complete("  something  do ")
      it("adds a  do", function()
        assert.are.same({"  something do", "    ", "  end"}, completion.lines)
      end)
    end)
  end)
end)
