require "../../spec_helper"
describe CCCompleters::Shell do

  standard_prefix = [
        "normal j$",
        "%%%End Commands%%%"]

  context "function accolades" do
    it "works" do
      input    = ["function hello"]
      output   = CCCompleters::Shell.new(input).complete
      expected = [
        "call append('.', repeat(' ', &sw))" ] +
        standard_prefix + [ 
        "function hello {",
        "}"]

      output.should eq(expected)
    end

    it "is a nop in case of not a function" do
      input    = [" function hello"]
      output   = CCCompleters::Shell.new(input).complete
      expected = [ "%%%End Commands%%%"] + input

      output.should eq(expected)
    end
  end
end
