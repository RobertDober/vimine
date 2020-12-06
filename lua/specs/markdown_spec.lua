local markdown = require('cccomplete.markdown')()
describe("markdown", function()

  local function it_behaves_like_a_nop(line)
    describe("nop line:" .. line, function()
      local completion = markdown.complete(line)
        it("same lines", function()
          assert.are.same({line}, completion.lines)
        end)
        it("has the correct offset", function()
          assert.is_equal(0, completion.offset)
        end)
        it("has the correct col", function()
          assert.is_equal(999, completion.col)
        end)
    end)
  end

  it_behaves_like_a_nop("")
  it_behaves_like_a_nop("Just a line")
  it_behaves_like_a_nop("# Just a headline")
    
end)