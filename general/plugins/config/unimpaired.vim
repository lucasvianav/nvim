" <Space><Space> surrounds current line
" or selection with [count] blank lines
nmap <Space><Space> <Plug>unimpairedBlankAround
xmap <Space><Space> <Plug>unimpairedBlankAround

" alt + j/k moves current line or
" selection [count] lines up/down
nmap <M-k> <Plug>unimpairedMoveUp
nmap <M-j> <Plug>unimpairedMoveDown
xmap <M-k> <Plug>unimpairedMoveKeepSelectionUp
xmap <M-j> <Plug>unimpairedMoveKeepSelectionDown
