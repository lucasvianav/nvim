local expand = vim.fn.expand

require('auto-session').setup({
    auto_session_enable_last_session = false,
    auto_session_enabled = true,
    auto_save_enabled = true,
    auto_restore_enabled = false,
    auto_session_suppress_dirs = {
        expand('~/Desktop'), expand('~/Documents'),
        expand('~/Downloads'), expand('/'),
        expand('~/Pictures'), expand('/home'),
        expand('~'),
    },
    pre_save_cmds    = { 'silent! tabdo NvimTreeClose' },
    -- TODO: create function to do this when restoring multiple windows
    -- pre_restore_cmds = { 'silent! windo e'             },
    auto_session_allowed_dirs = nil,
})

