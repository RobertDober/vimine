RSpec.describe CCCompleter do
  shared_examples_for "module_function_completer" do
    let :context do
      mk_context(
        ft: "ruby",
        lines: ["  #{module_function} something (;.)"]
      )
    end
    it do
        expected = mk_context(
          cursor: [43, 4],
          ft: "ruby",
          lines: [
            "  module_function def something (;.)",
            "    ",
            "  end"
          ])
        expect( described_class.complete(context) ).to eq(expected)
    end
    
  end
  describe "Module Functions" do
    
    context "module_function" do
      let(:module_function) { "module_function" }
      it_behaves_like("module_function_completer")
    end
    
    context "mf" do
      let(:module_function) { "mf" }
      it_behaves_like("module_function_completer")
    end
  end
end

