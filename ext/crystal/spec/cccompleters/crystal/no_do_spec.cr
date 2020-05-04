require "../../spec_helper"
describe CCCompleters::Crystal do

  standard_prefix = [
        "normal j$",
        "%%%End Commands%%%"]

  context "no do for class/def/module" do
    it "works for top level class" do
      input    = ["class Klass"]
      output   = CCCompleters::Crystal.new(input).complete
      expected = [
        "call append('.', '' . repeat(' ', &sw))" ] +
        standard_prefix + [ 
        "class Klass",
        "end"]

      output.should eq(expected)
    end

    it "works for an indented def" do
      line     = "  def mymethod( a : String )"
      output   = CCCompleters::Crystal.new([line]).complete
      expected = [
        "call append('.', '  ' . repeat(' ', &sw))" ] +
        standard_prefix + [ 
        line, 
        "  end"]

      output.should eq(expected)
    end

    it "works for a module and spourious lines" do
      line     = "  module Alpha"
      output   = CCCompleters::Crystal.new([line, "some text"]).complete
      expected = [
        "call append('.', '  ' . repeat(' ', &sw))" ] +
        standard_prefix + [ 
        line, 
        "  end",
        "some text"]

      output.should eq(expected)
    end
  end
  
end

