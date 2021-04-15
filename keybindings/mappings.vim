" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Use alt + shift + hjkl to resize windows
nnoremap <M-J>    :resize -2<CR>
nnoremap <M-K>    :resize +2<CR>
nnoremap <S-A-H>    :vertical resize -2<CR>
nnoremap <S-A-L>    :vertical resize +2<CR>

" I hate escape more than anything else
inoremap jk <Esc>
inoremap kj <Esc>

" Unbind escape key if not on VSCode
if !exists('g:vscode')
    :inoremap <Esc> <Nop>
endif

" Easy CAPS
inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<Esc>

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" Use control-c instead of escape
nnoremap <C-c> <Esc>
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better tabbing in visual mode
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Break line after current position
nnoremap ]b a<CR><Esc>k$

" Break line before current position
nnoremap [b i<CR><Esc>k$

" Select last pasted text
nnoremap gp `[v`]
nnoremap gP `[V`]

" Duplicate line below
nmap <expr> ]d 'yy' . v:count1 . 'p' . ']p'
xmap <expr> ]d 'y' . v:count1 . 'P' . ']pgv=gv'

" Duplicate line above
nmap <expr> [d 'yy' . v:count1 . 'P' . ']p'
xmap <expr> [d 'y' . v:count1 . 'P' . ']pgP'

nmap <Leader>o o<Esc>^Da
nmap <Leader>O O<Esc>^Da

" Maps m to delete 1 char
nmap m dl

" Hide highlights
nnoremap <silent> <Leader>n :noh<CR>

" Folding toggle
nnoremap <silent> ´ za
nnoremap <silent> ` zA
xnoremap <silent> ´ za
xnoremap <silent> ` zA
nnoremap <silent> <F9> za
nnoremap <silent> <F10> zA
xnoremap <silent> <F9> za
xnoremap <silent> <F10> zA
inoremap <silent> <F9> <Esc>za a
inoremap <silent> <F10> <Esc>zA a