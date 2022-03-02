-- TODO: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/statusline.lua
-- TODO: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/utils/statusline.lua
-- TODO: https://github.com/mattleong/CosmicNvim/blob/main/lua/cosmic/core/statusline/init.lua
-- TODO: https://github.com/nvim-lualine/lualine.nvim
-- TODO: https://github.com/Famiu/feline.nvim
-- TODO: https://github.com/windwp/windline.nvim
-- https://www.reddit.com/r/neovim/comments/pxkf16/windlinenvim_one_global_status_line_on_floating/

-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

local utils = require('v.utils.statusline')
local colors = require('v.utils.colors')
local lualine_utils = require('lualine.utils.utils')

local bubbles_theme = {
    normal = {
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.black, bg = lualine_utils.extract_highlight_colors('Normal', 'bg') },
        x = { fg = colors.white, bg = colors.black },
        y = { fg = colors.black, bg = colors.red },
        z = { fg = colors.white, bg = colors.off_black },
    },

    insert = { y = { fg = colors.black, bg = colors.blue } },
    visual = { y = { fg = colors.black, bg = colors.cyan } },
    replace = { y = { fg = colors.black, bg = colors.yellow } },

    inactive = {
        a = { fg = colors.cyan_grey, bg = colors.off_black },
        b = { fg = colors.cyan_grey, bg = colors.off_black },
        c = { fg = colors.off_black, bg = colors.off_black },
    },
}

require('lualine').setup({
    options = {
        theme = bubbles_theme,
        component_separators = '|',
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = {},
        lualine_b = { 'filename', 'require("v.utils.statusline").get_current_files_dir()' },
        lualine_c = { 'diagnostics' },
        lualine_x = { 'branch', 'filetype', 'progress' },
        lualine_y = {
            { 'mode' },
        },
        lualine_z = {
            {
                'progress',
                fmt = function(str)
                    return ' ' .. str
                end,
            },
            {
                'location',
                -- get col
                fmt = function(str)
                    return '㏇' .. str:sub(5)
                end,
            },
        },
    },
    inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},

        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})
