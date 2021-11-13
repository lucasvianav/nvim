let blocklist = [ 'prompt', 'nofile' ]

augroup RelativeNumberManagement
    au!
    au InsertEnter * set norelativenumber
    au InsertLeavePre * if index(blocklist, &bt) < 0 | set relativenumber | endif
augroup END
