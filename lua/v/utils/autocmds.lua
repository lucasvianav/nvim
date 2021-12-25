-- TODO: https://github.com/akinsho/dotfiles/blob/f714d4cdd2de74c7393ca3ae69bdbb3619e06174/.config/nvim/lua/as/globals.lua#L211-L243

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
M.augroup = function(name, autocmds, options)
    if type(name) ~= 'string' or type(autocmds) ~= 'table' then
        vim.api.nvim_notify('Invalid parameter(s).', vim.log.levels.ERROR, {
            title = 'Augroups',
        })
        require('v.utils.wrappers').inspect(name, autocmds)
        return
    end

    options = vim.tbl_extend('keep', options or {}, { bang = true })

    vim.api.nvim_command('augroup ' .. name)
    if options.bang and not options.buffer then
        vim.api.nvim_command('au!')
    elseif options.bang and options.buffer then
        vim.api.nvim_command('au! * <buffer>')
    end

    for _, tbl in ipairs(autocmds) do
        if options.buffer then
            if #tbl == 2 then
                table.insert(tbl, 2, '<buffer>')
            elseif #tbl == 3 then
                if type(table[2]) == 'table' then
                    table.insert(tbl, '<buffer>')
                else
                    tbl[2] = { tbl[2], '<buffer>' }
                end
            end
        end

        M.autocmd(unpack(tbl))
    end

    vim.api.nvim_command('augroup END')
end

return M
