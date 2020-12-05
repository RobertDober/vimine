describe("ruby", function()
  -- tests go here

  describe("a nested block", function()
    describe("can have many describes", function()
      -- tests
      it("works", function()
              assert.is_nil(nil)
      end)
    end)
  end)

  -- more tests pertaining to the top level
end)

