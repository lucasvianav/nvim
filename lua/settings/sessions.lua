vim.api.nvim_command([[augroup LoadSessionOrDashboard]])
vim.api.nvim_command([[au!]])
vim.api.nvim_command([[au VimEnter * lua load_session_or_dashboard()]])
vim.api.nvim_command([[augroup END]])

