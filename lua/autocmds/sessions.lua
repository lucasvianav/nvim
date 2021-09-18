
vim.cmd('augroup SessionManagement')
vim.cmd('au!')
vim.cmd('au VimEnter * lua load_session_or_dashboard()')
if session_autoload_provider == 'custom' then
    vim.cmd('au VimLeavePre * lua save_cwd_session()')
end
vim.cmd('augroup END')
