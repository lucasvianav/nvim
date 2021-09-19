local M = {}

function M.getAll(use)
    local _use = get_packer_use_wrapper(use, '_packer.plugins.git')

    -- git CLI for command mode
    _use({
        'tpope/vim-fugitive',
        requires = {
            'tpope/vim-rhubarb',    -- integration with GitHub
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
        },
    })

     -- git decorations
     _use({
         'lewis6991/gitsigns.nvim',
         after = 'plenary.nvim',
         event = 'BufNew',
     })
end

return M


