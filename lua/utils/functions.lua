local M = {}

function map(mode, lhs, rhs, opt)
    local available_modes = 'nvsxo!ilct'
    if #mode ~= 1 or not string.find(available_modes, mode) then return end

    local options = vim.tbl_extend('force', { noremap = true, silent = true }, opt or {})
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)

    return options
end
M.map = map

function unmap(mode, lhs)
    vim.api.nvim_set_keymap(mode, lhs, '<nop>', {})
end
M.unmap = unmap


return M
