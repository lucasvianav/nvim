local actions = require('telescope.actions')
local state = require('telescope.actions.state')

local M = {}

M.open_in_diff = function(prompt_bufnr)
    actions.close(prompt_bufnr)
    local commit_hash = state.get_selected_entry().value

    local ok_packer, packer = require('v.utils.packer').get_packer()

    if ok_packer then
        pcall(packer.loader, 'diffview.nvim')
        require('diffview').open(commit_hash .. '~1..' .. commit_hash)
    end
end

return M
