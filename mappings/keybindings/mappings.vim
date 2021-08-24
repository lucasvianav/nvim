" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Use alt + shift + hjkl to resize windows
nnoremap <silent> <S-M-J> :resize -2<CR>
nnoremap <silent> <S-M-K> :resize +2<CR>
nnoremap <silent> <S-A-H> :vertical resize -2<CR>
nnoremap <silent> <S-A-L> :vertical resize +2<CR>

" leave normal mode
inoremap jk <Esc>

" Use control-c instead of escape
nnoremap <C-c> <Esc>
" Unbind escape key
inoremap <Esc> <Nop>

" Buffer movement with <Tab> and <S-Tab>
nnoremap <silent> <TAB> :bnext<CR>
nnoremap <silent> <S-TAB> :bprevious<CR>

" toggle buffer
nnoremap <silent> <Leader><Tab> <C-^>
nnoremap <silent> <BS> <C-^>

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better tabbing in visual mode
vnoremap < <gv
vnoremap > >gv

" Better tabbing in insert mode
inoremap <S-TAB> <C-D>

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

nmap <Leader>o o<C-c>^Da
nmap <Leader>O O<C-c>^Da

" Hopefully <C-BS> deletes word in insert mode
imap <C-h> <Space><C-c>dbi

" Hide highlights
nnoremap <silent> <Leader>n :noh<CR>

nnoremap '' ``

noremap <Up> <nop>
noremap <Down> <nop>
noremap <Right> <nop>
noremap <Left> <nop>

inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Right> <nop>
inoremap <Left> <nop>

