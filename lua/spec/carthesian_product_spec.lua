local make = require'carthesian_product.maker'.make

local subject
local function with_subject(...)
  subject = {...}
end
local function result()
  return make(subject, "_")
end

describe("Carthesian Product", function()
  context("Simple case", function()
    with_subject("alpha beta")
    it("returns just the list", function()
      assert.are.same({"alpha", "beta"}, result())
    end)
  end)

  context("A better case", function()
    with_subject("alpha beta", "1 2 3")
    it("returns the carthesian product", function()
      local expected = {
        "alpha_1", "alpha_2", "alpha_3",
        "beta_1", "beta_2", "beta_3",
      }
      assert.are.same(expected, result())
    end)
  end)

  context("Whew, shall I bootstrap this in vim ;)", function()
    with_subject("alpha beta", "1 2 3", "x y")
    it("returns the carthesian product", function()
      local expected = {
        "alpha_1_x", "alpha_1_y",
        "alpha_2_x", "alpha_2_y",
        "alpha_3_x", "alpha_3_y",
        "beta_1_x", "beta_1_y",
        "beta_2_x", "beta_2_y",
        "beta_3_x", "beta_3_y",
      }
      assert.are.same(expected, result())
    end)
  end)
end)
