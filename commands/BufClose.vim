command! -nargs=? -complete=buffer -bang Bclose
            \ :call BufClose('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang BClose
            \ :call BufClose('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang Bufclose
            \ :call BufClose('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang BufClose
            \ :call BufClose('<args>', '<bang>')

function! BufClose(buffer, bang)
    if a:buffer == ''
        " No buffer provided, use the current buffer.
        let buffer = bufnr('%')
    elseif (a:buffer + 0) > 0
        " A buffer number was provided.
        let buffer = bufnr(a:buffer + 0)
    else
        " A buffer name was provided.
        let buffer = bufnr(a:buffer)
    endif

    if buffer == -1
        echohl ErrorMsg
        echomsg "No matching buffer for" a:buffer
        echohl None
        return
    endif

    " if the file was now saved and ! wasn't passed
    if a:bang == '' && getbufvar(buffer, '&modified')
        echohl ErrorMsg
        echom "E89: no write since last change"
        echohl None

    " single window case
    elseif winnr('$') == 1
        silent execute 'bd' . a:bang . ' ' . buffer

    " multiple window case
    else
        let oldbuf = bufnr('%')
        let oldwin = winnr()
        while 1   " all windows that display oldbuf will remain open
            if buflisted(bufnr('#'))
                b#
            else
                bn
                let curbuf = bufnr('%')
                if curbuf == oldbuf
                    enew    " oldbuf is the only buffer, create one
                endif
            endif
            let win = bufwinnr(oldbuf)
            if win == -1
                break
            else        " there are other window that display oldbuf
                exec win 'wincmd w'
            endif
        endwhile
        " delete oldbuf and restore window to oldwin
        silent execute 'bd' . a:bang . ' ' . oldbuf
        silent exec oldwin 'wincmd w'
    endif
endfunc
