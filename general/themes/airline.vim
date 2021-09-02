" tabline config
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'

" sections
let g:airline_section_a = ' ' " mode
let g:airline_section_c = ''  " filepath
let g:airline_section_y = ''  " encoding

" config
let g:airline_powerline_fonts = 1
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_detect_crypt=1
" let g:airline_stl_path_style = 0
let g:airline_inactive_collapse=1
let g:airline#extensions#capslock#enabled = 1
let g:airline#extensions#whitespace#enabled = 0

" extension integration
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#csv#enabled = 1
let g:airline#extensions#csv#column_display = 'Name'
let g:airline#extensions#fzf#enabled = 1
let g:airline#extensions#vimtex#enabled = 0

" vimtex config
" let g:airline#extensions#vimtex#left = \"{\"\n
" let g:airline#extensions#vimtex#right = \"}\"\n

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" overriding symbols
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.linenr = ' ☰ ㏑'
let g:airline_symbols.maxlinenr = ' '
let g:airline_symbols.colnr = '㏇'
let g:airline_symbols.spell = 'Ꞩ'

" matching with current theme
let g:airline_theme = 'deep_space'

" Always show tabs
set showtabline=4

" hide -- INSERT --
set noshowmode
