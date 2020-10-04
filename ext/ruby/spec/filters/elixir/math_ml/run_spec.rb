RSpec.describe MathML do
 
  context "prefix" do
    it "aligns the output to the indent of the first line" do
      input = ["   A three space indent"]
      output = described_class.run(input)

      expect(output.first).to eq(input.first)
    end
  end
end
