" override onedark
if (has("autocmd"))
    augroup colorextend
        autocmd!
        " Make `Function`s bold in GUI mode
        autocmd ColorScheme * call onedark#extend_highlight("Function", { "gui": "bold" })
    augroup END
endif

let g:onedark_terminal_italics=1
let g:onedark_termcolors=256
let g:onedark_hide_endofbuffer=0

