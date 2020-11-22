RSpec.describe CCCompleter do
  shared_examples_for "a CCCompleter" do
    it {
      expect( described_class.complete(input_context) ).to eq(expected_context)
    }
  end

  context "Given" do
    describe "simple case" do
      let(:input_context) do
        mk_md_context(
          lines: [
            "Given"
          ])
      end
      let(:expected_context) do
        mk_md_context(
          cursor: [44, 4],
          lines: [
            "Given",
            "```ruby",
            "    ",
            "```" ])
      end
      it_behaves_like "a CCCompleter"
    end

    describe "simple case ★ indent: 3" do
      let(:input_context) do
        mk_md_context(
          lines: [
            "   Given"
          ])
      end
      let(:expected_context) do
        mk_md_context(
          cursor: [44, 4],
          lines: [
            "   Given",
            "```ruby",
            "    ",
            "```" ])
      end
      it_behaves_like "a CCCompleter"
    end

    describe "simple case ★ indent: 4" do
      let(:input_context) do
        mk_md_context(
          lines: [
            "    Given"
          ])
      end
      let(:expected_context) do
        mk_md_context(
          cursor: [42, 9],
          lines: [
            "    Given"])
      end
      it_behaves_like "a CCCompleter"
    end

  end

  context "Then" do
    describe "simple case" do
      let(:input_context) do
        mk_md_context(
          lines: [
            "Then"
          ])
      end
      let(:expected_context) do
        mk_md_context(
          cursor: [44, 4],
          lines: [
            "Then",
            "```ruby",
            "    ",
            "```" ])
      end
      it_behaves_like "a CCCompleter"
    end

    describe "simple case ★ indent: 3" do
      let(:input_context) do
        mk_md_context(
          lines: [
            "   Then"
          ])
      end
      let(:expected_context) do
        mk_md_context(
          cursor: [44, 4],
          lines: [
            "   Then",
            "```ruby",
            "    ",
            "```" ])
      end
      it_behaves_like "a CCCompleter"
    end

    describe "simple case ★ indent: 4" do
      let(:input_context) do
        mk_md_context(
          lines: [
            "    Then"
          ])
      end
      let(:expected_context) do
        mk_md_context(
          cursor: [42, 8],
          lines: [
            "    Then"])
      end
      it_behaves_like "a CCCompleter"
    end

  end

  context "And" do
    describe "simple case" do
      let(:input_context) do
        mk_md_context(
          lines: [
            "And"
          ])
      end
      let(:expected_context) do
        mk_md_context(
          cursor: [44, 4],
          lines: [
            "And",
            "```ruby",
            "    ",
            "```" ])
      end
      it_behaves_like "a CCCompleter"
    end

    describe "simple case ★ indent: 3" do
      let(:input_context) do
        mk_md_context(
          lines: [
            "   And"
          ])
      end
      let(:expected_context) do
        mk_md_context(
          cursor: [44, 4],
          lines: [
            "   And",
            "```ruby",
            "    ",
            "```" ])
      end
      it_behaves_like "a CCCompleter"
    end

    describe "simple case ★ indent: 4" do
      let(:input_context) do
        mk_md_context(
          lines: [
            "    And"
          ])
      end
      let(:expected_context) do
        mk_md_context(
          cursor: [42, 7],
          lines: [
            "    And"])
      end
      it_behaves_like "a CCCompleter"
    end

  end


  context "But" do
    describe "simple case" do
      let(:input_context) do
        mk_md_context(
          lines: [
            "But"
          ])
      end
      let(:expected_context) do
        mk_md_context(
          cursor: [44, 4],
          lines: [
            "But",
            "```ruby",
            "    ",
            "```" ])
      end
      it_behaves_like "a CCCompleter"
    end

    describe "simple case ★ indent: 3" do
      let(:input_context) do
        mk_md_context(
          lines: [
            "   But"
          ])
      end
      let(:expected_context) do
        mk_md_context(
          cursor: [44, 4],
          lines: [
            "   But",
            "```ruby",
            "    ",
            "```" ])
      end
      it_behaves_like "a CCCompleter"
    end

    describe "simple case ★ indent: 4" do
      let(:input_context) do
        mk_md_context(
          lines: [
            "    But"
          ])
      end
      let(:expected_context) do
        mk_md_context(
          cursor: [42, 7],
          lines: [
            "    But"])
      end
      it_behaves_like "a CCCompleter"
    end

  end

  context "Example: " do
    describe "simple case" do
      let(:input_context) do
        mk_md_context(
          lines: [
            "Example: "
          ])
      end
      let(:expected_context) do
        mk_md_context(
          cursor: [44, 4],
          lines: [
            "Example: ",
            "```ruby",
            "    ",
            "```" ])
      end
      it_behaves_like "a CCCompleter"
    end

    describe "simple case ★ indent: 3" do
      let(:input_context) do
        mk_md_context(
          lines: [
            "   Example: "
          ])
      end
      let(:expected_context) do
        mk_md_context(
          cursor: [44, 4],
          lines: [
            "   Example: ",
            "```ruby",
            "    ",
            "```" ])
      end
      it_behaves_like "a CCCompleter"
    end

    describe "simple case ★ indent: 4" do
      let(:input_context) do
        mk_md_context(
          lines: [
            "    Example: "
          ])
      end
      let(:expected_context) do
        mk_md_context(
          cursor: [42, 13],
          lines: [
            "    Example: "])
      end
      it_behaves_like "a CCCompleter"
    end

  end
end
