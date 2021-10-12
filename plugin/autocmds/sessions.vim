augroup SessionManagement
    au!
    au VimEnter * lua require('functions').sessions.load_session_or_dashboard()
augroup END

