augroup SessionManagement
    au!
    au VimEnter * lua require('v.utils.sessions').load_session_or_dashboard()
augroup END

