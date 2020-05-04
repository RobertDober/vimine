require "../../spec_helper"
describe CZCompleters::Elixir do

  context "@spec" do
    it "works for a function" do
      input    = ["@spec", "  def hello(..."]
      output   = CZCompleters::Elixir.new(input, %w[42]).complete
      expected = [
        "call cursor(42, 14)",
        Tools::System::EndOfCommands,
        "  @spec hello() :: ",
        "  def hello(..."]

        output.should eq(expected)
    end

    it "does not touch other contexts" do
      line1    = "@spec"
      line2    = "  xdef hello(..."
      input    = [line1, line2]
      output   = CZCompleters::Elixir.new(input, %w[42]).complete
      expected = [
        Tools::System::EndOfCommands,
        line1,
        line2]

        output.should eq(expected)
    end
  end
end
