local M = {}

local fn = vim.fn
local cmd = vim.cmd

function _G.map(mode, lhs, rhs, opt)
    local available_modes = 'nvsxo!ilct'
    if #mode ~= 1 or not string.find(available_modes, mode) then return end

    local options = vim.tbl_extend('force', { noremap = true, silent = true }, opt or {})
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)

    return options
end
M.map = map

function _G.unmap(mode, lhs)
    vim.api.nvim_set_keymap(mode, lhs, '<nop>', {})
end
M.unmap = unmap

function _G._loadfile(module)
    return function() return require(module) end
end
M.loadfile = _loadfile

function _G.loadSessionOrDashboard()
    local sessionsDir = fn.expand('~/.local/share/nvim/sessions/')
    local cwd = fn.expand(fn.getcwd())
    local session = sessionsDir .. fn.substitute(cwd, '/', '\\%', 'g') .. '.vim'
    local noArguments = vim.fn.argc()

    if fn.filereadable(session) == 1 then
        cmd('silent! RestoreSession')
    elseif noArguments == 0 then
        cmd('silent! Dashboard')
    end
end
M.loadSessionOrDashBoard = loadSessionOrDashboard

return M
