require('auto-session').setup({
    auto_session_enable_last_session = false,
    auto_session_enabled = true,
    auto_save_enabled = true,
    auto_restore_enabled = false,
    pre_save_cmds = { 'silent! tabdo NvimTreeClose' },
    auto_session_allowed_dirs = nil,

    -- fix Neovim height after it is started, so
    -- cmdheight isn't super large (#64) (#11330)
    post_restore_cmds = { 'silent !kill -s SIGWINCH $PPID' },

    -- TODO: create function to do this when restoring multiple windows
    -- pre_restore_cmds = { 'silent! tabdo windo e | silent! tabdo windo zv' },

    -- TODO: maybe swap for allowed dirs
    auto_session_suppress_dirs = require('v.utils.wrappers').expand_in_list({
        '/',
        '/home',
        '~',
        '~/Desktop',
        '~/Documents',
        '~/Downloads',
        '~/Pictures',
    }),

    bypass_session_save_file_types = {
        '',
        'NvimTree',
        'NvimTree_*',
        'dashboard',
        'gitcommit',
        'help',
        'lsp-installer',
        'packer',
        'packer',
        'startify',
        'terminal',
        'text',
        'text',
    },
})
