local expand = vim.fn.expand

require('auto-session').setup({
    auto_session_enable_last_session = false,
    auto_session_enabled = false,
    auto_save_enabled = true,
    auto_restore_enabled = false,
    auto_session_suppress_dirs = {
        expand('~/Desktop'), expand('~/Documents'),
        expand('~/Downloads'), expand('/'),
        expand('~/Pictures'), expand('/home'),
        expand('~'),
    },
    auto_session_allowed_dirs = nil,
})

-- setup custo auto restore
vim.api.nvim_command([[augroup LoadSessionOrDashboard]])
vim.api.nvim_command([[au!]])
vim.api.nvim_command([[au VimEnter * lua loadSessionOrDashboard()]])
vim.api.nvim_command([[augroup END]])

