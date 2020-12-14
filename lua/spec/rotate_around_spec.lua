local rotate_around = require'rotate_around.maker'.rotate_around

local subject
local function set_subject(col, line, sep)
  local sep = sep or "_"
  subject = rotate_around(col, sep, line)
end

local function assert_rotation(with)
  it("returns...", function()
    assert.is_equal(with, subject)
  end)
end

describe("rotation around _", function()
  context("2 elements, nothing around", function()
    set_subject(0, "alpha_beta")
    assert_rotation("beta_alpha")
  end)
  context("2 elements with prefix", function()
    --              0....+....1
    set_subject(10, "prefix alpha_beta")
    assert_rotation("prefix beta_alpha")
  end)
  context("3 elements with suffix and custom pattern #wip", function()
    --              0....+....1
    set_subject(10, "a, b, (c, d, e) and, so", ", ")
    assert_rotation("a, b, (d, e, c) and, so")
  end)
end)
