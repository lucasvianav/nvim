let g:Illuminate_delay = 500
let g:Illuminate_highlightUnderCursor = 0

augroup illuminate_augroup
    autocmd!
    " autocmd VimEnter * hi illuminatedWord ctermbg=LightGray guibg=LightGray " ctermfg=Black guifg=Black
    autocmd VimEnter * hi illuminatedWord guibg=#595959 " ctermfg=Black guifg=Black
augroup END

let g:Illuminate_ftHighlightGroups = {
      \ 'vim': ['vimVar', 'vimString', 'vimLineComment',
      \         'vimFuncName', 'vimFunction', 'vimUserFunc', 'vimFunc']
      \ }

let g:Illuminate_ftwhitelist = [
    \ 'vim', 'sh', 'python', 'node',
    \ 'javascript', 'py', 'js', 'c',
    \ 'cpp', 'h'
\ ]

let g:Illuminate_ftblacklist = [
    \ 'nerdtree', 'coc',
    \ 'cocexplorer', 'coc-explorer'
\ ]

" nnoremap <a-n> :lua require"illuminate".next_reference{wrap=true}<cr>
" nnoremap <a-p> :lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>
