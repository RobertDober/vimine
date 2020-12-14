local lt = require'tools.list'

local subject
local function set_subject(val)
  subject = val
end

local function assert_rotate_left(by, expected)
  it("rotates left by " .. by, function()
    assert.are.same(expected, lt.rotate_left(subject, by))
  end)
end

local function assert_rotate_right(by, expected)
  it("rotates right by " .. by, function()
    assert.are.same(expected, lt.rotate_right(subject, by))
  end)
end

context("empty table", function()
  set_subject({})
  assert_rotate_left(1, {})
  assert_rotate_left(2, {})
  assert_rotate_right(1, {})
  assert_rotate_right(2, {})
end)

context("one element tables", function()
  set_subject({"one"})
  assert_rotate_left(1, {"one"})
  assert_rotate_left(2, {"one"})
  assert_rotate_right(1, {"one"})
  assert_rotate_right(2, {"one"})
end)

context("two element tables", function()
  set_subject({"one", "two"})
  assert_rotate_left(1, {"two", "one"})
  assert_rotate_left(2, {"one", "two"})
  assert_rotate_right(1, {"two", "one"})
  assert_rotate_right(2, {"one", "two"})
end)

context("three element tables", function()
  set_subject({"one", "two", "three"})
  assert_rotate_left(1, {"two", "three", "one"})
  assert_rotate_right(2, {"two", "three", "one"})
  assert_rotate_left(2, {"three", "one", "two"})
  assert_rotate_right(1, {"three", "one", "two"})
end)
