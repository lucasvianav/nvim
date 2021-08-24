" tabbing in visual mode
" maintains selection
vnoremap < <gv
vnoremap > >gv

" selects last pasted text
nnoremap gp `[v`]
nnoremap gP `[V`]

" hides highlights
nnoremap <silent> <Leader>n :noh<CR>

" untabs in insert mode
inoremap <S-TAB> <C-D>

