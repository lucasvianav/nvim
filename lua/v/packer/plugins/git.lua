-- TODO: https://github.com/pwntester/octo.nvim

local M = {
    -- show commit in floating window
    {
        'rhysd/git-messenger.vim',
        keys = '<leader>gm',
        cmd = 'GitMessenger',
    },

    -- git CLI for command mode
    -- TODO: something like this would be nice https://www.reddit.com/r/neovim/comments/qatokl/using_nvim_as_mergetool_with_vimfugitive/
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
            '<leader>gg',
            '<Leader>ga',
            { 'v', '<leader>gg' },
        },
    },

    -- git decorations
    -- TODO: config this
    {
        'lewis6991/gitsigns.nvim',
        after = 'plenary.nvim',
        event = 'CursorHold',
    },

    -- practical git diff for modified files
    {
        'sindrets/diffview.nvim',
        cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
        after = 'devicons',
    },
}

return M
