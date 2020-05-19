require "../../spec_helper"
describe CZCompleters::Ruby do

  context "isolated symbol" do
    it "in middle of line" do
      #         0....+....1....
      input = [%{  this(:symbol}]
      output   = CZCompleters::Elixir.new(input, %w[42 8]).complete
      expected = [
        "call cursor(42, 8)",
        Tools::System::EndOfCommands,
        %{  this("symbol"}]

        output.should eq(expected)
    end
  end
end
