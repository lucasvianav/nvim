local M = {}

function M.getAll(use)
    local _use = get_packer_use_wrapper(use, '_packer.plugins.git')

    _use({ 'tpope/vim-fugitive', cmd = { 'Git' } }) -- git CLI for command mode

     -- git decorations
     _use({
         'lewis6991/gitsigns.nvim',
         after = 'plenary.nvim',
         event = 'BufNew',
     })
end

return M


