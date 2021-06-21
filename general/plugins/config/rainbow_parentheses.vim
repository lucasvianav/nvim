let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

" disable dark gray parenthesis
let g:rainbow#blacklist = [248]

autocmd FileType * RainbowParentheses
" autocmd FileType html,css RainbowParentheses!
