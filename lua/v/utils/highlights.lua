local M = {}

---Wrapper for defining highlights with `:highlight`
---@param group string the highlighting group's name
---@param tbl table<string,string> the highlighting modifications
---@return nil
M.highlight = function(group, tbl)
    if type(group) ~= 'string' or type(tbl) ~= 'table' then
        vim.api.nvim_notify('Invalid parameter(s).', vim.log.levels.ERROR, {
            title = 'Highlights',
        })
        require('v.utils.wrappers').inspect(group, tbl)
        return
    end

    local cmd = 'hi! ' .. group

    for key, value in pairs(tbl) do
        if type(key) == 'string' and value and type(value) == 'string' then
            cmd = ('%s %s=%s'):format(cmd, key, value)
        elseif value == 'transparent' then
            cmd = cmd .. 'ctermbg=NONE guibg=NONE'
        end
    end

    vim.api.nvim_command(cmd)
end

---@class HighlightTable
---@field group string the highlighting group's name
---@field tbl table<string,string> the highlighting modifications

---Wrapper for defining multiple highlights (`:h :highlight`) in one function call
---@param args HighlightTable[]
---@return nil
M.set_highlights = function(args)
    for _, cmd_table in ipairs(args) do
        M.highlight(unpack(cmd_table))
    end
end

return M
