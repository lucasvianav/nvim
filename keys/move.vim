function! s:Visual()
    return visualmode() == 'V'
endfunction


function! s:Move(address, at_limit)
    if s:Visual() && !a:at_limit
        execute "'<,'>move " . a:address
        call feedkeys('gv=', 'n')
    endif
    call feedkeys('gv', 'n')
endfunction


function! s:Move_up() abort range
    let l:at_top=a:firstline == 1
    call s:Move("'<-2", l:at_top)
endfunction


function! s:Move_down() abort range
    let l:at_bottom=a:lastline == line('$')
    call s:Move("'>+1", l:at_bottom)
endfunction

" Move VISUAL LINE selection within buffer.
xnoremap <silent> K :call <SID>Move_up()<CR>
xnoremap <silent> J :call <SID>Move_down()<CR>
