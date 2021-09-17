vim.cmd([[
augroup SessionManagement
au!
au VimEnter    * lua load_session_or_dashboard()
au VimLeavePre * lua save_cwd_session()
augroup END
]])
