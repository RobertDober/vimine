RSpec.describe RubyCompleter do
  context "elixir" do
    context "complete function call" do
      let(:input) {
        #....+....1....+....2....+....3....+....4....+....5
        " @type ast_attribute  :: {ast_attribute_name, ast_attribute_value}" }
      let(:output) {
        #....+....1....+....2....+....3....+....4....+....5
        " @type ast_attribute  :: {ast_attribute_name(), ast_attribute_value}" }

      let(:context) {{
        ft: "elixir",
        line: input,
        cursor: [1, 32]
      }}
      it "adds ()" do
        expect_completed(context, output, 46)
      end
    end
  end
end
