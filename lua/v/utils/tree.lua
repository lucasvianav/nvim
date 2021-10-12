local M = {}

--[[
    Is NvimTree open?
]]
M.is_nvim_tree_open = false

--[[
    Open NvimTree with :NvimTreeFind file and closes it with :NvimTreeClose.
]]
function M.nvim_tree_toggle()
    local is_packer_loaded, packer = pcall(require, 'packer')

    if is_packer_loaded then
        packer.loader('nvim-tree')
    end

    local is_nvim_tree_loaded, nvim_tree = pcall(require, 'nvim-tree')

    if is_nvim_tree_loaded then
        if M.is_nvim_tree_open then
            nvim_tree.toggle()
            require('nvim-tree.lib').collapse_all()
            M.is_nvim_tree_open = false
        else
            nvim_tree.find_file(true)
            M.is_nvim_tree_open = true
        end
    end
end

return M
