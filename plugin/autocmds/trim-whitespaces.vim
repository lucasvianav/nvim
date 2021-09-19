augroup TrimTrailingWhitespaces
    au!
    au! BufWritePre * :lua trim_trailing_whitespaces()
augroup END
