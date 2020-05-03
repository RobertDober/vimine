require "../../spec_helper"
describe Completers::Elixir do

  standard_prefix = [
        "normal j$",
        "%%%End Commands%%%"]


  context "do for most lines" do
    it "works for def" do
      input    = ["    def times(n)"]
      output   = Completers::Elixir.new(input).complete
      expected = [
        "call append('.', '    ' . repeat(' ', &sw))" ] +
        standard_prefix + [ 
        "    def times(n) do",
        "    end"]

      output.should eq(expected)
    end
  end
end
