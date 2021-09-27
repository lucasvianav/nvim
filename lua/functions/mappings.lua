local set_keymap = vim.api.nvim_set_keymap
local fn         = vim.fn

--[[
Wrapper for vim.api.nvim_set_keymap(), but defaulting `noremap` and 'silent' options.
]]--
-- TODO: support buf --- https://github.com/lukas-reineke/dotfiles/blob/5b84e9264d3ca9e40fd773642e5a1d335224733e/vim/lua/utils.lua#L32-L37
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

function _G.CR()
    local has_npairs, npairs = pcall(require, 'nvim-autopairs')

    if fn.pumvisible() ~= 0 then
        if fn.complete_info({ 'selected' }).selected == -1 then
            return has_npairs and ( npairs.esc('<c-e>') .. npairs.autopairs_cr() ) or t'<C-e><CR>'
        else
            return has_npairs and npairs.esc('<c-y>') or t'<C-y>'
        end
    else
        return has_npairs and npairs.autopairs_cr() or t'<CR>'
    end
end

function _G.BS()
    local has_npairs, npairs = pcall(require, 'nvim-autopairs')

    if fn.pumvisible() ~= 0 and fn.complete_info({ 'mode' }).mode == 'eval' then
        return has_npairs and ( npairs.esc('<c-e>') .. npairs.autopairs_bs() ) or t'<C-e><BS>'
    else
        return has_npairs and npairs.autopairs_bs() or t'<BS>'
    end
end



