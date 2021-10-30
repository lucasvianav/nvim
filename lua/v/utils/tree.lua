local M = {}

--[[
    Open NvimTree with :NvimTreeFind file and closes it with :NvimTreeClose.
]]
function M.nvim_tree_toggle()
    local is_packer_loaded, packer = require('v.utils.packer').get_packer()

    if is_packer_loaded then
        packer.loader('nvim-tree')
    end

    local is_nvim_tree_loaded, nvim_tree = pcall(require, 'nvim-tree')

    if is_nvim_tree_loaded then
        require('nvim-tree.lib').collapse_all()
        nvim_tree.toggle(true)
    end
end

return M
