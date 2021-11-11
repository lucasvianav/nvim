augroup RelativeNumberManagement
    au!
    au InsertEnter * set norelativenumber
    au InsertLeavePre * if &bt != 'prompt' | set relativenumber | endif
augroup END
