require "../../spec_helper"
describe CCCompleters::Crystal do

  standard_prefix = [
        "normal j$",
        "%%%End Commands%%%"]

  context "do for most lines" do
    it "works for a lambda line" do
      input    = ["    times"]
      output   = CCCompleters::Crystal.new(input).complete
      expected = [
        "call append('.', '    ' . repeat(' ', &sw))" ] +
        standard_prefix + [ 
        "    times do",
        "    end"]

      output.should eq(expected)
    end
  end
  
end

