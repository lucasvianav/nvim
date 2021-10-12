local api = vim.api
local fn  = vim.fn

local M = {}

--  _____ _   _ _   _  ____ _____ ___ ___  _   _ ____
-- |  ___| | | | \ | |/ ___|_   _|_ _/ _ \| \ | / ___|
-- | |_  | | | |  \| | |     | |  | | | | |  \| \___ \
-- |  _| | |_| | |\  | |___  | |  | | |_| | |\  |___) |
-- |_|    \___/|_| \_|\____| |_| |___\___/|_| \_|____/

--[[
    Returns the current file's directory if it has one, "---" otherwise.
]]
function M.get_current_files_dir()
    local dir_name = fn.fnamemodify(api.nvim_buf_get_name(0), ':h:t')
    return dir_name ~= '.' and dir_name or '---'
end

--[[
    Returns the current line percentage (cursor position/lines in file).
]]
function M.get_line_percentage()
    local current = fn.line('.')
    local last    = fn.line('$')

    if current == 1 then
        return '  Top '
    elseif current == last then
        return '  Bot '
    end

    local percentage = math.modf((current / last) * 100)
    return '  ' .. (percentage > 0 and percentage .. '% ' or 'Top ')
end

--[[
    Returns the column the cursor currently in.
]]
function M.get_column()
    local tbl = vim.api.nvim_win_get_cursor(0)
    return '  ' .. (tbl[2] + 1) .. ' '
end




--  ____ ___  _     ___  ____  ____
-- / ___/ _ \| |   / _ \|  _ \/ ___|
--| |  | | | | |  | | | | |_) \___ \
--| |__| |_| | |__| |_| |  _ < ___) |
-- \____\___/|_____\___/|_| \_\____/

M.colors = {}
local colors = require('v.utils.colors')
local has_gl, gl_colors = pcall(require, 'galaxyline.themes.colors')

if has_gl then
    local get_color = gl_colors.get_color

    M.colors = {
        bg          = colors.black,
        bg_dark     = colors.blacker,
        bg_light    = colors.off_black,
        black       = colors.blacker,
        blue        = get_color('blue')(),
        cyan        = get_color('cyan')(),
        fg          = get_color('fg_alt')(),
        fg_dark     = colors.cyan_grey,
        fg_light    = colors.off_white,
        green       = get_color('green')(),
        magenta     = get_color('magenta')(),
        orange      = get_color('orange')(),
        red         = get_color('red')(),
        transparent = 'NONE',
        yellow      = get_color('yellow')(),
    }
end

M.colors = vim.tbl_extend('keep', M.colors, colors)

return M
