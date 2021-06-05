let g:terminal_buffer_n = 0
let g:is_terminal_open = 0

function! PutTermPanel(buf, side, size) abort
    " new term if no buffer
    if !a:buf || !bufexists(g:terminal_buffer_n)
        split | term
        let g:terminal_buffer_n = bufnr("$")
        let g:is_terminal_open = 1
        call setbufvar(g:terminal_buffer_n, "&buflisted", 0)
    else
        execute "sp" bufname(a:buf)
        call setbufvar(a:buf, "&buflisted", 0)
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
    " if the terminal is open, hide it
    if g:is_terminal_open && bufexists(g:terminal_buffer_n)
        silent execute bufwinnr(g:terminal_buffer_n) . "hide"
        let g:is_terminal_open = 0
    else " otherwise, open terminal
        call PutTermPanel(g:terminal_buffer_n, a:side, a:size)
        let g:is_terminal_open = 1
    endif
endfunction

" Toggle terminal - bottom
command ToggleTermBottom :call <SID>ToggleTerminal('J', 6)
nnoremap <silent> <Leader>t :ToggleTermBottom<CR>

" Toggle terminal - right
command ToggleTermRight :call <SID>ToggleTerminal('L', 60)
nnoremap <silent> <Leader>tr :ToggleTermRight<CR>

