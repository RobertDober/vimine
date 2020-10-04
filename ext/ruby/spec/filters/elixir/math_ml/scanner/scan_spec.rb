RSpec.describe MathML::Scanner do

  context "Scan all types" do
    let(:input) do
      #   0      1    2  3            4  5    6          7
      %w[ $alpha $x-4 a: beta-gamma:: a= b-== some%thing ; ]
    end
    let(:output) { described_class.scan(input.values_at(*concerned_input)) }

    context "cmps:" do
      let(:concerned_input) { [3] }

      it "have correct type" do
        expect( output.map(&:type).uniq ).to eq(%i[cmp])
      end
      it "have correct value" do
        expect( output.map(&:value) ).to eq(%w[beta-gamma])
      end
    end

    context "defs:" do
      let(:concerned_input) { [4, 5] }

      it "have correct type" do
        expect( output.map(&:type).uniq ).to eq(%i[def])
      end
      it "have correct value" do
        expect( output.map(&:value) ).to eq(%w[a b-=])
      end
    end

    context "ends:" do
      let(:concerned_input) { [7] }

      it "have correct type" do
        expect( output.map(&:type).uniq ).to eq(%i[end])
      end
      it "have correct value" do
        expect( output.map(&:value) ).to eq([nil])
      end
    end

    context "refs:" do
      let(:concerned_input) { [0, 1] }

      it "have correct type" do
        expect( output.map(&:type).uniq ).to eq(%i[ref])
      end
      it "have correct value" do
        expect( output.map(&:value) ).to eq(%w[alpha x-4])
      end
    end

    context "smps:" do
      let(:concerned_input) { [2] }

      it "have correct type" do
        expect( output.map(&:type).uniq ).to eq(%i[smp])
      end
      it "have correct value" do
        expect( output.map(&:value) ).to eq(%w[a])
      end
    end

    context "vbts:" do
      let(:concerned_input) { [6] }

      it "have correct type" do
        expect( output.map(&:type).uniq ).to eq(%i[vbt])
      end
      it "have correct value" do
        expect( output.map(&:value) ).to eq(%w[some%thing])
      end
    end

    context "all types:" do
      let(:concerned_input) { 0..7 }
      it "conserve original text" do
        expect(output.map(&:text)).to eq(input)
      end
    end
  end
  
end
