RSpec.describe MathML do
 
  context "prefix" do
    it "indents" do
      input = [" a: b c: d"]
      output = described_class.run(input)

      expect(output).to eq("<a>b</a><c>d</c>")
      
    end

    it "complex" do
      input = [
        "mt= mtr::",
        "$mt mtd:: a: b c: d",
        "; mtd:: x ;",
        ";"
       ]
      output = described_class.run(input)

      expect(output).to eq("<a>b</a><c>d</c>")
      
    end
  end
end
