---@class Autocommands
local M = {}

---@class Autocommand
---@field events string|string[]
---@field patterns string|string[]
---@field action string

---Wrapper for `:autocmd`
---@param events string|string[]
---@param patterns string|string[]
---@param action string
---@return nil
M.autocmd = function(events, patterns, action)
    if type(events) == 'table' then
        events = table.concat(events, ',')
    end

    if type(patterns) == 'table' then
        patterns = table.concat(patterns, ',')
    end

    if type(events) ~= 'string' or type(action) ~= 'string' or type(patterns) ~= 'string' then
        vim.api.nvim_notify('Invalid parameter(s).', vim.log.levels.ERROR, {
            title = 'Autocommands',
        })
        require('v.utils.wrappers').inspect(events, patterns, action)
        return
    end

    vim.api.nvim_command(('au %s %s %s'):format(events, patterns, action))
end

---Wrapper for setting augroups and autocmds
---@param name string
---@param autocmds Autocommand[] will be unpacked and passed to this module's autocmd()
---@return nil
M.augroup = function(name, autocmds)
    if type(name) ~= 'string' or type(autocmds) ~= 'table' then
        vim.api.nvim_notify('Invalid parameter(s).', vim.log.levels.ERROR, {
            title = 'Augroups',
        })
        require('v.utils.wrappers').inspect(name, autocmds)
        return
    end

    vim.api.nvim_command('augroup ' .. name)
    vim.api.nvim_command('au!')

    for _, a in ipairs(autocmds) do
        M.autocmd(unpack(a))
    end

    vim.api.nvim_command('augroup END')
end

return M
