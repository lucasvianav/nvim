" buffer movement with <Tab> and <S-Tab>
nnoremap <silent> \<TAB> :bnext<CR>
nnoremap <silent> \<S-TAB> :bprevious<CR>

" toggle buffer last visited buffer
nnoremap <silent> <Leader><Tab> <C-^>
nnoremap <silent> <BS> <C-^>

" better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

nnoremap '' ``
