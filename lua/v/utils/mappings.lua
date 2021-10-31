local t = require('v.utils.wrappers').termcode
local fn = vim.fn

-- TODO: create functions for autocmds, augroups and commands
-- https://github.com/akinsho/dotfiles/blob/148d1b720b296ad9ef6943da4e7b9d2c4f86c59b/.config/nvim/lua/as/globals.lua#L178-L206
-- https://github.com/akinsho/dotfiles/blob/148d1b720b296ad9ef6943da4e7b9d2c4f86c59b/.config/nvim/lua/as/globals.lua#L320-L334
-- https://github.com/danielnehrig/nvim/blob/4331ba8b2f3d4676476dabaa2f82e31b00061e6e/lua/utils/init.lua#L26-L41

-- TODO: setup whichkey registering on the fly
-- https://github.com/folke/which-key.nvim#-setup
-- https://github.com/akinsho/dotfiles/blob/c81dadf0c570ce39543a9b43a75f41256ecd03fc/.config/nvim/lua/as/plugins/lspconfig.lua#L61-L119

local M = {}

--[[
Wrapper for vim.api.nvim_set_keymap(), but defaulting `noremap` and 'silent' options.
]]
function M.map(modes, lhs, rhs, opts)
    if not lhs then
        vim.api.nvim_notify("Didn't receive a LHS.", 4, { title = 'Unmapping' })
        return
    elseif type(modes) ~= 'table' then
        modes = { modes }
    end

    local options = vim.tbl_extend('force', {
        -- disable noremap for <Plug> mappings
        noremap = rhs:lower():match('^<plug>.+') == nil,
        silent = true,
    }, opts or {})

    local buffer = options.buffer
    local bufnr = options.bufnr
    options.buffer = nil
    options.bufnr = nil

    local available_modes = 'nvsxo!ilct'

    for _, mode in ipairs(modes) do
        local is_valid_mode = string.find(available_modes, mode)

        if #mode == 1 and is_valid_mode then
            if buffer then
                vim.api.nvim_buf_set_keymap(bufnr or 0, mode, lhs, rhs, options)
            else
                vim.api.nvim_set_keymap(mode, lhs, rhs, options)
            end
        end
    end
end

--[[
Wrapper for vim.api.nvim_set_keymap(), mapping the `lhs` to `<nop>`.
]]
function M.unmap(modes, lhs)
    if not lhs then
        vim.api.nvim_notify("Didn't receive a LHS.", vim.log.levels.ERROR, { title = 'Unmapping' })
        return
    elseif type(modes) ~= 'table' then
        modes = { modes }
    end

    local available_modes = 'nvsxo!ilct'

    for _, mode in ipairs(modes) do
        local is_valid_mode = string.find(available_modes, mode)

        if #mode == 1 and is_valid_mode then
            vim.api.nvim_set_keymap(mode, lhs, t('<nop>'), {})
        end
    end
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

function M.set_keybindings(args)
    for _, map_table in ipairs(args) do
        M.map(unpack(map_table))
    end
end

function M.unset_keybindings(args)
    for _, map_table in ipairs(args) do
        M.unmap(unpack(map_table))
    end
end

return M
