function s:DuplicateLine(...)
    if a:0
        let s:direction = a:1
    endif
    let s:cursorCol = getpos('.')[2]

    let command = "normal yy" . v:count1 . (s:direction == "down" ? "p" : "P") . "]p"
    execute command

    let cursorPos = getcurpos()
    let s:cursorPos = [ cursorPos[0], a:0 ? cursorPos[1] : ( (s:direction == "down") ? s:cursorPos[1] + v:count1 : s:cursorPos[1] ), s:cursorCol, cursorPos[3], s:cursorCol ]

    call setpos('.', s:cursorPos)

    silent! call repeat#set("\<Plug>DuplicateLineRepeat", v:count1)
endfunction

function s:DuplicateSelection(...)
    if mode() != "V"
        return
    endif

    if a:0
        let s:direction = a:1
    endif
    let s:cursorCol = col(".")
    let s:lower_line = max([line("."), line("v")])

    let command = "normal y" . ((s:direction == "down") ? s:lower_line . "Gj" : "") . v:count1 . "P]p`[V`]"
    execute command

    let cursorPos = getcurpos()
    let s:cursorPos = [ cursorPos[0], a:0 ? cursorPos[1] : ( (s:direction == "down") ? s:cursorPos[1] + v:count1 : s:cursorPos[1] ), s:cursorCol, cursorPos[3], s:cursorCol ]

    call setpos('.', s:cursorPos)

    silent! call repeat#set("\<Plug>DuplicateSelectionRepeat", v:count1)
endfunction

nnoremap <silent> <script> <Plug>DuplicateLineAbove :<C-u>call <SID>DuplicateLine("up")<CR>
nnoremap <silent> <script> <Plug>DuplicateLineBelow :<C-u>call <SID>DuplicateLine("down")<CR>
nnoremap <silent> <script> <Plug>DuplicateLineRepeat :<C-u>call <SID>DuplicateLine()<CR>

xnoremap <script> <Plug>DuplicateSelectionAbove <Cmd>call <SID>DuplicateSelection("up")<CR>
xnoremap <script> <Plug>DuplicateSelectionBelow <Cmd>call <SID>DuplicateSelection("down")<CR>
xnoremap <script> <Plug>DuplicateSelectionRepeat <Cmd>call <SID>DuplicateSelection()<CR>

" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Use alt + shift + hjkl to resize windows
nnoremap <silent> <S-M-J> :resize -2<CR>
nnoremap <silent> <S-M-K> :resize +2<CR>
nnoremap <silent> <S-A-H> :vertical resize -2<CR>
nnoremap <silent> <S-A-L> :vertical resize +2<CR>

" I hate escape more than anything else
inoremap jk <Esc>
inoremap JK <Esc>

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

" Duplicate line above
nmap <silent> [d <Plug>DuplicateLineAbove
xmap <silent> [d <Plug>DuplicateSelectionAbove

" Duplicate line below
nmap <silent> ]d <Plug>DuplicateLineBelow
xmap <silent> ]d <Plug>DuplicateSelectionBelow

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
