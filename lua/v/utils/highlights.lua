local M = {}

---Wrapper for defining highlights like with `:highlight`
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

    for pos, value in ipairs(tbl) do
        if value == 'transparent' then
            tbl.ctermbg = 'NONE'
            tbl.guibg = 'NONE'
        end

        tbl[pos] = nil
    end

    if type(tbl.gui) == 'table' then
        tbl.gui = table.concat(tbl.gui, ',')
    end

    if type(tbl.cterm) == 'table' then
        tbl.cterm = table.concat(tbl.cterm, ',')
    end

    vim.highlight.create(group, tbl)

    --[[ version using `:hi!`
        local cmd = 'hi! ' .. group

        for key, value in pairs(tbl) do
            if type(key) == 'string' and value and type(value) == 'string' then
                cmd = ('%s %s=%s'):format(cmd, key, value)
            elseif value == 'transparent' then
                cmd = cmd .. 'ctermbg=NONE guibg=NONE'
            end
        end

        vim.api.nvim_command(cmd)
    ]]
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

---Convert a hex color to RGB
---@param color string
---@return number Red
---@return number Blue
---@return number Green
local function __hex_to_rgb(color)
    local hex = color:gsub('#', '')
    return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5), 16)
end

local function __alter(attr, percent)
    return math.floor(attr * (100 + percent) / 100)
end

---Lighten/darken a specified hex color
---@param color string
---@param percent number
---@return string
---@source https://stackoverflow.com/q/5560248
---@source https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/highlights.lua
---@see: https://stackoverflow.com/a/37797380
function M.alter_color(color, percent)
    local r, g, b = __hex_to_rgb(color)

    if not r or not g or not b then
        return 'NONE'
    end

    r, g, b = __alter(r, percent), __alter(g, percent), __alter(b, percent)
    r, g, b = math.min(r, 255), math.min(g, 255), math.min(b, 255)
    return string.format('#%02x%02x%02x', r, g, b)
end

return M