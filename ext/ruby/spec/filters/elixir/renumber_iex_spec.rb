require "filters/elixir/renumber_iex"

RSpec.describe RenumberIex do

  describe "nop" do
    let(:lines) {[
      "   iex(99)>", "hello"
    ]}

    it "does not modify any lines" do
      output = described_class.run(lines)
      expect( output ).to eq(lines)
    end
  end

  describe "bring order" do
    it "into disorder" do
      lines = [
        "    ...(9)> first",
        "",
        "    iex(10)> second",
        "      ...(1)> third"]
      expected = [ 
        "    iex(1)> first",
        "",
        "    iex(2)> second",
        "    ...(2)> third"]
      output = described_class.run(lines)
      expect( output ).to eq(expected)
    end
    it "into order" do
      lines = [ 
        "    iex(1)> first",
        "",
        "    iex(2)> second",
        "    ...(2)> third"]
      output = described_class.run(lines)
      expect( output ).to eq(lines)
    end
  end

  describe "the short form" do
    it "helps during development" do
      lines = [
        "    ...(9)> first",
        "",
        "    iex(10)> second",
        "     > third"]
      expected = [ 
        "    iex(1)> first",
        "",
        "    iex(2)> second",
        "    ...(2)> third"]
      output = described_class.run(lines)
      expect( output ).to eq(expected)
    end
  end
  
end

