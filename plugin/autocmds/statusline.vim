fun! s:disable_nvimtree_statusline()
    if bufname('%') =~# 'NvimTree_\d\{1,}'
        set laststatus=0
    else
        set laststatus=2
    endif
endfunction

augroup DisableNvimTreeStatusline
    au!
    au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * call s:disable_nvimtree_statusline()
augroup END

