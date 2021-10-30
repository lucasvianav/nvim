-- TODO: kdheepak/lazygit.nvim
-- TODO: sindrets/diffview.nvim
-- https://www.reddit.com/r/neovim/comments/n2vww8/diffviewnvim_cycle_through_diffs_for_all_modified/
-- https://www.reddit.com/r/neovim/comments/n2vww8/diffviewnvim_cycle_through_diffs_for_all_modified/gwnahs3/

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
            '<leader>gb',
            '<Leader>ga',
            { 'v', '<leader>gb' },
        },
    },

    -- git decorations
    -- TODO: config this
    {
        'lewis6991/gitsigns.nvim',
        after = 'plenary.nvim',
        event = 'CursorHold',
    },
}

return M