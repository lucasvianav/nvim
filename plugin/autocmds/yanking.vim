augroup HighlightYankedText
    au!
    au TextYankPost * silent! lua vim.highlight.on_yank({ on_visual=false })
augroup END
