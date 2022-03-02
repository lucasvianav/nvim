-- TODO: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/statusline.lua
-- TODO: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/utils/statusline.lua
-- TODO: https://github.com/mattleong/CosmicNvim/blob/main/lua/cosmic/core/statusline/init.lua

--  _   _ _____ ___ _     ___ _____ ___ _____ ____
-- | | | |_   _|_ _| |   |_ _|_   _|_ _| ____/ ___|
-- | | | | | |  | || |    | |  | |  | ||  _| \___ \
-- | |_| | | |  | || |___ | |  | |  | || |___ ___) |
--  \___/  |_| |___|_____|___| |_| |___|_____|____/

local cmd = vim.api.nvim_command

local gl = require('galaxyline')
local gls = gl.section

local condition = require('galaxyline.condition')
local fileinfo = require('galaxyline.providers.fileinfo')

local utils = require('v.utils.statusline')
local colors = utils.colors

local mode_colors = {
    [110] = { name = 'NORMAL', color = colors.red },
    [105] = { name = 'INSERT', color = colors.magenta },
    [99] = { name = 'COMMAND', color = colors.yellow },
    [116] = { name = 'TERMINAL', color = colors.green },
    [118] = { name = 'VISUAL', color = colors.cyan },
    [22] = { name = 'V-BLOCK', color = colors.cyan },
    [86] = { name = 'V_LINE', color = colors.cyan },
    [82] = { name = 'REPLACE', color = colors.orange },
    [115] = { name = 'SELECT', color = colors.blue },
    [83] = { name = 'S-LINE', color = colors.blue },
}

local icons = {
    addition = '  ',
    bar = '▋',
    diff = '   ',
    dir = '  ',
    empty = '  ',
    engine = '   ',
    error = '  ',
    git = '  ',
    left = '',
    main = 'ಠ_ಠ ', -- 🌜
    pos_col = '㏇',
    position = ' ',
    remotion = '  ',
    right = ' ', -- 
    vi_mode = ' ',
    warning = '  ',
}

local function str(args)
    return function()
        return args
    end
end

local function mode(field)
    local current_mode = vim.fn.mode()
    return mode_colors[current_mode:byte()][field]
end

--   ____    _    _        _    __  ____   ___     ___ _   _ _____
--  / ___|  / \  | |      / \   \ \/ /\ \ / / |   |_ _| \ | | ____|
-- | |  _  / _ \ | |     / _ \   \  /  \ V /| |    | ||  \| |  _|
-- | |_| |/ ___ \| |___ / ___ \  /  \   | | | |___ | || |\  | |___
--  \____/_/   \_\_____/_/   \_\/_/\_\  |_| |_____|___|_| \_|_____|

gl.short_line_list = { 'NvimTree', 'NvimTree_*', 'packer' }

gls.left = {
    {
        LeftPadding = {
            provider = str(' '),
            highlight = { colors.bg_light, colors.bg_light },
        },
    },
    {
        FileIcon = {
            provider = 'FileIcon',
            condition = condition.buffer_not_empty,
            highlight = { colors.fg_dark, colors.bg_light },
        },
    },
    {
        FileName = {
            provider = function()
                return (vim.api.nvim_buf_get_name(0):len() == 0) and icons.empty
                    or fileinfo.get_current_file_name('', '')
            end,
            highlight = { colors.fg, colors.bg_light },
            separator = icons.right,
            separator_highlight = { colors.bg_light, colors.bg },
        },
    },
    {
        CurrentDir = {
            provider = function()
                local dir_name = utils.get_current_files_dir()
                return icons.dir .. dir_name .. ' '
            end,
            highlight = { colors.fg_dark, colors.bg },
            separator = icons.right,
            separator_highlight = { colors.bg, colors.transparent },
        },
    },
}

gls.mid = {
    {
        DiagnosticError = {
            provider = 'DiagnosticError',
            icon = icons.error,
            highlight = { colors.red, colors.transparent },
        },
    },
    {
        DiagnosticWarn = {
            provider = 'DiagnosticWarn',
            icon = icons.warning,
            highlight = { colors.yellow, colors.transparent },
        },
    },
}

gls.right = {
    {
        GitIcon = {
            provider = str(icons.git),
            condition = condition.check_git_workspace,
            highlight = { colors.fg, colors.bg },
            separator = icons.left,
            separator_highlight = { colors.bg, colors.transparent },
        },
    },
    {
        GitBranch = {
            provider = 'GitBranch',
            condition = condition.check_git_workspace,
            highlight = { colors.fg, colors.bg },
        },
    },
    {
        LeftArrow = {
            provider = str('  '),
            highlight = {
                colors.fg,
                condition.check_git_workspace() and colors.bg or colors.bg,
            },
        },
    },
    {
        LeftRound = {
            provider = function()
                cmd('hi GalaxyLeftRound guifg=' .. mode('color'))
                return icons.left
            end,
            highlight = {
                'GalaxyViMode',
                condition.check_git_workspace() and colors.bg or colors.bg,
            },
        },
    },
    {
        ViModeIcon = {
            provider = function()
                cmd('hi GalaxyViModeIcon guibg=' .. mode('color'))
                return icons.vi_mode
            end,
            highlight = { colors.blacker, colors.red },
        },
    },
    {
        ViMode = {
            provider = function()
                cmd('hi GalaxyViMode guifg=' .. mode('color'))
                return '  ' .. mode('name') .. ' '
            end,
            highlight = { 'GalaxyViMode', colors.bg },
        },
    },
    {
        SomeRoundicon = {
            provider = str(icons.position),
            separator = icons.left,
            separator_highlight = { colors.green, colors.bg },
            highlight = { colors.blacker, colors.green },
        },
    },
    {
        LinePercentage = {
            provider = utils.get_line_percentage,
            highlight = { colors.green, colors.bg },
        },
    },
    {
        ColRoundicon = {
            provider = str(icons.pos_col),
            separator = icons.left,
            separator_highlight = { colors.yellow, colors.bg },
            highlight = { colors.blacker, colors.yellow },
        },
    },
    {
        Column = {
            provider = utils.get_column,
            highlight = { colors.yellow, colors.bg },
        },
    },
}

gls.short_line_left = {
    {
        LeftPadding = {
            provider = str(' '),
            highlight = { colors.transparent, colors.transparent },
        },
    },
    {
        FileIcon = {
            provider = 'FileIcon',
            condition = condition.buffer_not_empty,
            highlight = { colors.fg_dark, colors.transparent },
        },
    },
    {
        FileName = {
            provider = function()
                return (vim.api.nvim_buf_get_name(0):len() == 0) and icons.empty
                    or fileinfo.get_current_file_name()
            end,
            highlight = { colors.fg_dark, colors.transparent },
        },
    },
}

require('v.utils.highlights').set_highlights({
    { 'StatusLine', { 'transparent' } },
    -- {
    --     'StatusLineNC',
    --     {
    --         gui = 'underline',
    --         guifg = colors.black,
    --         'transparent',
    --     },
    -- },
})
