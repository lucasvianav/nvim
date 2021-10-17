-- TODO: kdheepak/lazygit.nvim

local M = {
    -- show git blame info on lines
    {
        'f-person/git-blame.nvim',
        keys = '<leader>gi',
        cmd = 'GitBameToggle',
    },

    -- show commit in floating window
    {
        'rhysd/git-messenger.vim',
        keys = '<leader>gm',
        cmd = 'GitMessenger',
    },

    -- git CLI for command mode
    {
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
    },

    -- git decorations
    {
        'lewis6991/gitsigns.nvim',
        after = 'plenary.nvim',
        event = 'CursorHold',
    },
}

return M
