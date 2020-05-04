require "../../spec_helper"
describe CCCompleters::Elixir do

  standard_prefix = [
        "normal j$",
        "%%%End Commands%%%"]


  context "|> pipelines" do
    it "works" do
      input    = ["   |> whatever%comlicated"]
      output   = CCCompleters::Elixir.new(input).complete
      expected = standard_prefix + input +
        [ "   |> "]

      output.should eq(expected)
    end
  end
end
