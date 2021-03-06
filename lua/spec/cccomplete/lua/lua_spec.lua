local lua = require('cccomplete.lua')()

local function complete(line)
  return lua.complete({line = line})
end

describe("lua", function()

  describe("complete without do", function()
    local function check_indented_completion(name, input, fncompleted)
      local fncompleted = fncompleted or input
      local indent = string.match(input, "^%s*")
      local completion = complete(input)
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

    check_indented_completion("global function with no params", "function X()")
    check_indented_completion("global function with no params, parens added", "  function X", "  function X()")
    check_indented_completion("local function with params", "  local function hello(world)")
    check_indented_completion("local function with params, rparen added", "  local function hello(world", "  local function hello(world)")
    check_indented_completion("globally assigned function", "alpha = function()")
    check_indented_completion("locally assigned function", "local beta = function(a, b, ...)")
    check_indented_completion("returned function", " return function(a, b, ...)")


    check_indented_completion("if (bare)", "  if some_condition", "  if some_condition then")
    check_indented_completion("if (with then)", "  if some_condition  then ", "  if some_condition then")
    check_indented_completion("elseif (bare)", "elseif some_condition", "elseif some_condition then")
    check_indented_completion("elseif (with then)", "elseif some_condition  then ", "elseif some_condition then")
    check_indented_completion("else (bare)", "else")

  end)

  describe("complete with do", function()
    describe("any line", function()
      completion = complete("  something")
      it("adds a  do", function()
        assert.are.same({"  something do", "    ", "  end"}, completion.lines)
      end)
    end)
    describe("any line do present", function()
      completion = complete("  something  do ")
      it("adds a  do", function()
        assert.are.same({"  something do", "    ", "  end"}, completion.lines)
      end)
    end)
  end)

  describe("complete table", function()
    describe("ends with {", function()
      completion = complete(" hello  {  ")
      it("adds a }", function()
        assert.are.same({" hello {", "   ", " }"}, completion.lines)
      end)
      it("has the correct offset", function()
        assert.is_equal(1, completion.offset)
      end)
      it("has the correct col", function()
        assert.is_equal(999, completion.col)
      end)
    end)
  end)
end)

