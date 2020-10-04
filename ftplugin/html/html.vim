function! s:mathMLLL(line1, line2) " {{{{{
  ruby << EOF
    require "filters/math_ml"
    fst_lnb = VIM.evaluate("a:line1")
    lst_lnb = VIM.evaluate("a:line2")
    range = fst_lnb.pred..lst_lnb.pred
    lines = VIM::Buffer.current.lines[range]
    output = MathML.run(lines) 
    VIM::Buffer.current.lines[range] = output
EOF
endfunction " }}}}}
command! -range MathMLLL call <SID>mathMLLL(<line1>, <line2>)
vnoremap <Leader>tc :MathMLLL<CR>
nnoremap <Leader>tc :MathMLLL<CR>
