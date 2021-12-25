" SOURCE: https://github.com/akinsho/dotfiles/blob/f714d4cdd2de74c7393ca3ae69bdbb3619e06174/.config/nvim/plugin/autocommands.lua#L379-L383

augroup MakeDirP
    au!
    au BufWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
    au FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
augroup END
