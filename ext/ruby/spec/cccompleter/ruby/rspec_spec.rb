RSpec.describe CCCompleter do
  context "RSpec context block comletion" do
    let :context do
      mk_context(
        ft: "ruby",
        lines: [' context "hello"'])
    end

    it "completes with do" do
      expected = mk_context(
        cursor: [43, 3],
        ft: "ruby",
        lines: [
          ' context "hello" do',
          "   ",
          " end" ])
      expect( described_class.complete(context) ).to eq(expected)
    end
  end

  context "RSpec context block completion with do" do
    let :context do
      mk_context(
        ft: "ruby",
        lines: [' context "hello" do'])
    end

    it "completes with do" do
      expected = mk_context(
        cursor: [43, 3],
        ft: "ruby",
        lines: [
          ' context "hello" do',
          "   ",
          " end" ])
      expect( described_class.complete(context) ).to eq(expected)
    end
  end
end
