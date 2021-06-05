function! PutTermPanel(buf, side, size) abort
    " new term if no buffer
    if a:buf == 0
        split | term
    else
        execute "sp" bufname(a:buf)
    endif
    " default side if wrong argument
    if stridx("hjklHJKL", a:side) == -1
        execute "wincmd" "J"
    else
        execute "wincmd" a:side
    endif
    " horizontal split resize
    if stridx("jkJK", a:side) >= 0
        if ! a:size > 0
            resize 6
        else
            execute "resize" a:size
        endif
        return
    endif
    " vertical split resize
    if stridx("hlHL", a:side) >= 0
        if ! a:size > 0
            vertical resize 6
        else
            execute "vertical resize" a:size
        endif
    endif
endfunction

function! s:ToggleTerminal(side, size) abort
    let tpbl=[]
    let closed = 0
    let tpbl = tabpagebuflist()
    " hide visible terminals
    for buf in filter(range(1, bufnr('$')), 'bufexists(bufname(v:val)) && index(tpbl, v:val)>=0')
        if getbufvar(buf, '&buftype') ==? 'terminal'
            silent execute bufwinnr(buf) . "hide"
            let closed += 1
        endif
    endfor
    if closed > 0
        return
    endif
    " open first hidden terminal
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)<0')
        if getbufvar(buf, '&buftype') ==? 'terminal'
            call PutTermPanel(buf, a:side, a:size)
            return
        endif
    endfor
    " open new terminal
    call PutTermPanel(0, a:side, a:size)
endfunction

" Toggle terminal - bottom
nnoremap <silent> <Leader>t :call <SID>ToggleTerminal('J', 6)<CR>

" Toggle terminal - right
nnoremap <silent> <Leader>tr :call <SID>ToggleTerminal('L', 60)<CR>

