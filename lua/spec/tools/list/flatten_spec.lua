local flatten = require'tools.list'.flatten

describe("flatten", function()
  local flat = {'a', 'b', 'c'}
  local nested = {'a', {'b', 'c'}}

  describe("idempotent", function()
    it("does nothing", function()
      assert.are.same(flat, flatten(flat))
    end)
    it('can be created from multi params', function()
      assert.are.same(flat, flatten('a', 'b', 'c'))
    end)
  end)

  describe('actually flattening', function()
    it("flattens a nested", function()
      assert.are.same(flat, flatten(nested))
    end)
    it('flattens with multi params', function()
      assert.are.same({0, 'a', 'b', 'c', 1}, flatten(0, flat, 1))
    end)
    it('flattens with multi params and nested', function()
      assert.are.same({0, 'a', 'b', 'c', 1}, flatten(0, nested, 1))
    end)
    it('a complex example for dessert', function()
      assert.are.same({'a', 'b', 'c', 0, 'a', 'b', 'c', 1}, flatten({nested, 0}, {flat}, 1))
    end)
  end)
end)
