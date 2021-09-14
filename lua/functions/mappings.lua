local set_keymap = vim.api.nvim_set_keymap

--[[
Wrapper for vim.api.nvim_set_keymap(), but defaulting `noremap` and 'silent' options.
]]--
function _G.map(mode, lhs, rhs, opt)
    local available_modes = 'nvsxo!ilct'
    if #mode ~= 1 or not string.find(available_modes, mode) then return end

    local options = vim.tbl_extend('force', { noremap = true, silent = true }, opt or {})
    set_keymap(mode, lhs, rhs, options)

    return options
end

--[[
Wrapper for vim.api.nvim_set_keymap(), mapping the `lhs` to `<nop>`.
]]--
function _G.unmap(mode, lhs)
    set_keymap(mode, lhs, t'<nop>', {})
end

