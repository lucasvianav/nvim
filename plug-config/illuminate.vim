let g:Illuminate_delay = 500
let g:Illuminate_highlightUnderCursor = 0

augroup illuminate_augroup
    autocmd!
    " autocmd VimEnter * hi illuminatedWordk ctermbg=15 guibg=#FFFFFF ctermfg=4 guifg=#8b0000
    autocmd VimEnter * hi illuminatedWord ctermbg=LightGrey guibg=LightGrey ctermfg=Black guifg=Black
augroup END

let g:Illuminate_ftHighlightGroups = {
      \ 'vim': ['vimVar', 'vimString', 'vimLineComment',
      \         'vimFuncName', 'vimFunction', 'vimUserFunc', 'vimFunc']
      \ }

let g:Illuminate_ftwhitelist = ['vim', 'sh', 'python', 'node', 'javascript', 'py', 'js', 'c', 'c++', 'cpp', 'h']
let g:Illuminate_ftblacklist = ['nerdtree', 'coc', 'cocexplorer', 'coc-explorer']

nnoremap <a-n> :lua require"illuminate".next_reference{wrap=true}<cr>
nnoremap <a-p> :lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>
