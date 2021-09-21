local M = {}

function M.getAll(use)
    local _use = get_packer_use_wrapper(use, '_packer.plugins.git')

    _use({ 'f-person/git-blame.nvim', event = 'CursorHold' }) -- show git blame info on lines

    -- show commit in floating window
    _use({
        'rhysd/git-messenger.vim',
        event = 'CursorHold',
        keys = '<leader>gm',
        cmd = 'GitMessenger',
    })

    -- git CLI for command mode
    _use({
        'tpope/vim-fugitive',
        requires = {
            'tpope/vim-rhubarb',    -- integration with GitHub
            'tommcdo/vim-fubitive', -- integration with BitBucket
        },
        cmd = {
            'Git', 'GBrowse', 'Gdiff',
            'Gdiffsplit', 'Gvdiffsplit',
        },
        keys = {
            '<leader>gd', '<leader>gh',
            '<leader>gl', '<leader>gb',
            { 'v', '<leader>gb' }
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


