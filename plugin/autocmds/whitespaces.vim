augroup TrimTrailingWhitespaces
    au!
    au BufWritePre * :lua require('v.utils').trim_trailing_whitespaces()
augroup END
