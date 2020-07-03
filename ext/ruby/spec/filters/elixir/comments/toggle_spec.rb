require "filters/comments/toggle"
RSpec.describe Toggle do

  let(:ft) { :dummy }

  describe "no comments" do
    it "comments one line" do
      lines = ["  hello"]
      result = described_class.run(lines, ft)

      expect( result ).to eq(["  # hello"])
    end

    it "or two" do
      lines = ["  hello", "world"]
      result = described_class.run(lines, ft)

      expect( result ).to eq(["  # hello", "# world"])
    end

    it "or none" do
      result = described_class.run([], ft)

      expect( result ).to eq([])
    end
  end

  describe "comments" do
    it "are easily removed" do
      lines = ["# hello", " # world", "  # again"]
      expected = ["hello", " world", "  again"]
      result = described_class.run(lines, ft)

      expect(result).to eq(expected)
    end
    it "empty lines do not disturb us" do
      lines = ["# hello", "", "  # again"]
      expected = ["hello", "", "  again"]
      result = described_class.run(lines, ft)

      expect(result).to eq(expected)
    end
  end

  describe "a wild mix" do
    it "cannot disturb us" do
      lines = [" hello", "", "  # again", "# ", "world"]
      expected = [" # hello", "", "  again", "", "# world"]
      result = described_class.run(lines, ft)

      expect(result).to eq(expected)
    end
  end
end
