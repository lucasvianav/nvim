" substitutes Esc by jk in insert
" mode and Ctrl+C in normal mode
inoremap jk <Esc>
nnoremap <C-c> <Esc>

" use alt + shift + hjkl to resize windows
nnoremap <silent> <S-M-J> :resize -2<CR>
nnoremap <silent> <S-M-K> :resize +2<CR>
nnoremap <silent> <S-A-H> :vertical resize -2<CR>
nnoremap <silent> <S-A-L> :vertical resize +2<CR>

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" break line after/before current position
nnoremap ]b a<CR><Esc>k$
nnoremap [b i<CR><Esc>k$

" get blank new line
nmap <Leader>o o<C-c>^Da
nmap <Leader>O O<C-c>^Da

