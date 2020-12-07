local access_by_match = require'tools'().access_by_match

local table = {
  ["^:[%a_]+$"] = "symbol",
  ["^'[%a_]+'$"] = "sq_id",
  ['^"[%a_]+"$'] = "dq_id",
}
describe("access_by_match", function()
  local function assert_corresponds(source, target)
    it(source .. "↔" .. target, function()
      assert.is_equal(access_by_match(source, table), target)
    end)
  end

  assert_corresponds(":hello", "symbol")
  assert_corresponds("'hello_world'", "sq_id")
  assert_corresponds('"ello_world"', "dq_id")

  local function assert_not_found(value)
    it("does not exist", function()
      assert.is_nil(access_by_match(value, table))
    end)
  end

  assert_not_found("hello")
  assert_not_found("a'hello'")
  assert_not_found('"a42"')
  assert_not_found('')
end)



