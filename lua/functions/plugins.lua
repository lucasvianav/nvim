--[[
Open NvimTree with :NvimTreeFind file and closes it with :NvimTreeClose.
]]
function _G.nvim_tree_toggle()
    local is_packer_loaded, packer = pcall(require, 'packer')

    if is_packer_loaded then
        packer.loader('nvim-tree')
    end

    local is_nvim_tree_loaded, nvim_tree = pcall(require, 'nvim-tree')

    if is_nvim_tree_loaded then
        if is_nvim_tree_open then
            nvim_tree.toggle()
            require('nvim-tree.lib').collapse_all()
            is_nvim_tree_open = false
        else
            nvim_tree.find_file(true)
            is_nvim_tree_open = true
        end
    end
end
