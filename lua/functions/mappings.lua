local fn = vim.fn
-- local t  = require('functions').wrappers.termcode

local M = {}

--[[
Wrapper for vim.api.nvim_set_keymap(), but defaulting `noremap` and 'silent' options.
]]
function M.map(modes, lhs, rhs, opts)
    if type(modes) ~= 'table' then
        modes = { modes }
    end

    local options = vim.tbl_extend('force', {
        noremap = true,
        silent = true,
    }, opts or {})
    local buffer = options.buffer
    options.buffer = nil

    local available_modes = 'nvsxo!ilct'

    for _, mode in ipairs(modes) do
        local is_valid_mode = string.find(available_modes, mode)

        if #mode == 1 and is_valid_mode then
            if buffer then
                vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, options)
            else
                vim.api.nvim_set_keymap(mode, lhs, rhs, options)
            end
        end
    end
end

--[[
Wrapper for vim.api.nvim_set_keymap(), mapping the `lhs` to `<nop>`.
]]
function M.unmap(mode, lhs)
    vim.api.nvim_set_keymap(mode, lhs, t('<nop>'), {})
end

function M.CR()
    local has_npairs, npairs = pcall(require, 'nvim-autopairs')

    if fn.pumvisible() ~= 0 then
        if fn.complete_info({ 'selected' }).selected == -1 then
            return has_npairs and (npairs.esc('<c-e>') .. npairs.autopairs_cr()) or t('<C-e><CR>')
        else
            return has_npairs and npairs.esc('<c-y>') or t('<C-y>')
        end
    else
        return has_npairs and npairs.autopairs_cr() or t('<CR>')
    end
end

function M.BS()
    local has_npairs, npairs = pcall(require, 'nvim-autopairs')

    if fn.pumvisible() ~= 0 and fn.complete_info({ 'mode' }).mode == 'eval' then
        return has_npairs and (npairs.esc('<c-e>') .. npairs.autopairs_bs()) or t('<C-e><BS>')
    else
        return has_npairs and npairs.autopairs_bs() or t('<BS>')
    end
end

_G.map   = M.map
_G.unmap = M.unmap
_G.CR    = M.CR
_G.BS    = M.BS

return M
