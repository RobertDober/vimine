RSpec.describe CCCompleter do
  context "VIM: Make a function" do
    describe "simple case" do
      let :context do
        mk_vim_context(
          lines: [" fun s:hello(x)"])
      end
      it "completes with folding" do
        expected = mk_vim_context(
          cursor: [43, 2],
          lines: [
            "function! s:hello(x) {{{{{",
            "  ",
            "endfunction }}}}}"
          ])

        expect( described_class.complete(context) ).to eq(expected)
      end

    end
    
  end
end

