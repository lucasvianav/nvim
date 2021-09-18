let s:provider = luaeval('session_autoload_provider')

augroup SessionManagement
au!
au VimEnter * lua load_session_or_dashboard()

if s:provider == 'custom'
    au VimLeavePre * lua save_cwd_session()
endif

augroup END

