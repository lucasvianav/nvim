local function expand(args)
    local tbl = {}

    for _, path in ipairs(args) do
        table.insert(tbl, vim.fn.expand(path))
    end

    return tbl
end

require('auto-session').setup({
    auto_session_enable_last_session = false,
    auto_session_enabled = true,
    auto_save_enabled = true,
    auto_restore_enabled = false,
    -- TODO: maybe swap for allowed dirs
    auto_session_suppress_dirs = expand({
        '/',
        '/home',
        '~',
        '~/Desktop',
        '~/Documents',
        '~/Downloads',
        '~/Pictures',
    }),
    pre_save_cmds    = { 'silent! tabdo NvimTreeClose' },
    -- TODO: create function to do this when restoring multiple windows
    -- pre_restore_cmds = { 'silent! windo e'             },
    auto_session_allowed_dirs = nil,
})

