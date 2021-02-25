if exists( 'g:vimine_rails_commands' )
  if g:vimine_rails_commands == 1
    finish
  else
    echomsg "(Re)loaded " . expand('<sfile>:p')
  endif
endif

if !filereadable('config.ru')
  finish
endif
let g:vimine_rails_commands = 1

function! s:completions(A, L, P)
  let l:candidates = [
        \ 'db/mig',
        \ 'app',
        \ 'app/controllers',
        \ 'app/jobs',
        \ 'app/machines',
        \ 'app/models',
        \ 'app/policies',
        \ 'app/serializers',
        \ 'app/services',
        \ 'app/validators',
        \ 'app/views',
        \ 'config',
        \ 'db',
        \ 'db/migrate',
        \ 'db/seeds',
        \ 'lib',
        \ 'spec',
        \ 'spec/acceptance',
        \ 'spec/factories',
        \ 'spec/fixtures',
        \ 'spec/jobs',
        \ 'spec/lib',
        \ 'spec/machines',
        \ 'spec/models',
        \ 'spec/policies',
        \ 'spec/requests',
        \ 'spec/serializers',
        \ 'spec/services',
        \ 'spec/support',
        \ 'tmp']
  return join(l:candidates, "\n")
endfunction
command! -nargs=1 -complete=custom,<SID>completions OpenDir NERDTree <args>
