local t = require('v.utils.wrappers').termcode
local fn = vim.fn

-- TODO: setup whichkey registering on the fly
-- https://github.com/folke/which-key.nvim#-setup
-- https://github.com/akinsho/dotfiles/blob/c81dadf0c570ce39543a9b43a75f41256ecd03fc/.config/nvim/lua/as/plugins/lspconfig.lua#L61-L119

local M = {}

--[[
Wrapper for vim.api.nvim_set_keymap(), but defaulting `noremap` and 'silent' options.
]]
function M.map(modes, lhs, rhs, opts)
    if not lhs then
        vim.api.nvim_notify("Didn't receive a LHS.", vim.log.levels.ERROR, {
            title = 'Unmapping',
        })
        return
    elseif type(modes) ~= 'table' then
        modes = { modes }
    end

    local options = vim.tbl_extend('force', {
        -- disable noremap for <Plug> mappings
        noremap = rhs:lower():match('^<plug>.+') == nil,
        silent = true,
        nowait = true, -- TODO: does this break anything?
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
