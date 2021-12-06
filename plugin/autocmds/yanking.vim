augroup YankHighlight
    au!
    au TextYankPost * silent! lua vim.highlight.on_yank()
augroup END
