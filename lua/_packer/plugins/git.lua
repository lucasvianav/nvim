local M = {}

--[[ TODO:
    kdheepak/lazygit.nvim
]]
--
function M.getAll(use)
    local _use = get_packer_use_wrapper(use, 'git')

    -- show git blame info on lines
    _use({
        'f-person/git-blame.nvim',
        keys = '<leader>gi',
        cmd = 'GitBameToggle',
    })

    -- show commit in floating window
    _use({
        'rhysd/git-messenger.vim',
        keys = '<leader>gm',
        cmd = 'GitMessenger',
    })

    -- git CLI for command mode
    _use({
        'tpope/vim-fugitive',
        requires = {
            'tpope/vim-rhubarb', -- integration with GitHub
            'tommcdo/vim-fubitive', -- integration with BitBucket
        },
        cmd = {
            'Git',
            'GBrowse',
            'Gdiff',
            'Gdiffsplit',
            'Gvdiffsplit',
        },
        keys = {
            '<leader>gd',
            '<leader>gh',
            '<leader>gl',
            '<leader>gb',
            '<Leader>ga',
            { 'v', '<leader>gb' },
        },
    })

    -- git decorations
    _use({
        'lewis6991/gitsigns.nvim',
        after = 'plenary.nvim',
        event = 'CursorHold',
    })
end

return M
