
function! s:railsdir(name)
  let l:parts = split(a:name, "/")
  if len(l:parts) < 2
    return ""
  endif
  if l:parts[0] == "app"
    if l:parts[1] == "webpack"
      return "JS"
    endif
    return toupper(l:parts[1][0:2])
  endif
  if l:parts[0] == "config"
    return "CON"
  endif
endfunction

function! Tabline()
  let s = '%'
 for i in range(tabpagenr('$'))
     let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tab .':'
    let s .= (bufname != '' ? '['. s:railsdir(bufname) . ' ' .fnamemodify(bufname, ':t') . '] ' : '[No Name] ')

    if bufmodified
      let s .= '+ '
    endif
  endfor

  let s .= '%#TabLineFill#'
  return s
endfunction
set tabline=%!Tabline()
