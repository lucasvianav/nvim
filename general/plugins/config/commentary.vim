nnoremap <silent> <C-_> :Commentary<CR>
vnoremap <silent> <C-_> :Commentary<CR>
autocmd BufEnter *.c,*.h,*cpp silent! :setlocal commentstring=//\ %s

