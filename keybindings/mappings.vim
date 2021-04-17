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
    let s:cursorCol = getpos('.')[2]
    let s:diff = getpos(".")[1] - getpos("v")[1]

    let command = "normal y" . ((s:direction == "down") ? s:diff . "j" : "") . v:count1 . ((s:direction == "down") ? "p" : "P") . "]p`[V`]"
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
nnoremap <M-J>    :resize -2<CR>
nnoremap <M-K>    :resize +2<CR>
nnoremap <S-A-H>    :vertical resize -2<CR>
nnoremap <S-A-L>    :vertical resize +2<CR>

" I hate escape more than anything else
inoremap jk <Esc>
inoremap kj <Esc>

" Use control-c instead of escape
nnoremap <C-c> <Esc>
" Unbind escape key if not on VSCode
if !exists('g:vscode')
    :inoremap <Esc> <Nop>
endif

" Easy CAPS
inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<Esc>

" Buffer movement with <Tab> and <S-Tab>
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>

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

" Duplicate line above
nmap <silent> [d <Plug>DuplicateLineAbove
xmap <silent> [d <Plug>DuplicateSelectionAbove

" Duplicate line below
nmap <silent> ]d <Plug>DuplicateLineBelow
xmap <silent> ]d <Plug>DuplicateSelectionBelow

nmap <Leader>o o<Esc>^Da
nmap <Leader>O O<Esc>^Da

" Maps m to delete 1 char
nmap m dl

" Hide highlights
nnoremap <silent> <Leader>n :noh<CR>

" Folding toggle
nnoremap <silent> <F9> za
nnoremap <silent> <F10> zA
xnoremap <silent> <F9> za
xnoremap <silent> <F10> zA
inoremap <silent> <F9> <Esc>za a
inoremap <silent> <F10> <Esc>zA a

nnoremap '' ``