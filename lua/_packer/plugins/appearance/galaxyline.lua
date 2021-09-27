-- TODO: refactor this whole file

local api = vim.api
local fn  = vim.fn
local lsp = vim.lsp
local cmd = vim.cmd






-- [[@VARIABLES
    local gl  = require('galaxyline') -- galaxyline
    local gls = gl.section            -- galaxyline.section

    local condition = require('galaxyline.condition')
    local get_color = require('galaxyline.themes.colors').get_color
    local _colors   = require('utils').colors
-- @VARIABLES]]






-- [[@COLORS
    local colors = {
        bg       = _colors.black,
        bg_dark  = _colors.blacker,
        bg_light = _colors.off_black,
        black    = _colors.blacker,
        blue     = get_color('blue')(),
        cyan     = get_color('cyan')(),
        fg       = get_color('fg_alt')(),
        fg_dark  = _colors.cyan_grey,
        fg_light = _colors.off_white,
        green    = get_color('green')(),
        magenta  = get_color('magenta')(),
        orange   = get_color('orange')(),
        red      = get_color('red')(),
        yellow   = get_color('yellow')(),
    }

    colors = vim.tbl_extend('keep', colors, _colors)
-- @COLORS]]






-- [[@UTILS
    local mode_colors = {
        [110] = { name = 'NORMAL',   color = colors.red     },
        [105] = { name = 'INSERT',   color = colors.magenta },
        [99]  = { name = 'COMMAND',  color = colors.yellow  },
        [116] = { name = 'TERMINAL', color = colors.green   },
        [118] = { name = 'VISUAL',   color = colors.cyan    },
        [22]  = { name = 'V-BLOCK',  color = colors.cyan    },
        [86]  = { name = 'V_LINE',   color = colors.cyan    },
        [82]  = { name = 'REPLACE',  color = colors.orange  },
        [115] = { name = 'SELECT',   color = colors.blue    },
        [83]  = { name = 'S-LINE',   color = colors.blue    },
    }

    local icons = {
        bar      = '▋'    ,
        left     = ''    ,
        right    = ' '   , -- 
        main     = 'ಠ_ಠ ' , -- 🌜
        vi_mode  = ' '   ,
        position = ' '   ,
        pos_col  = '㏇'   ,
        empty    = '  '  ,
        dir      = '  '  ,
        error    = '  '  ,
        warning  = '  '  ,
        addition = '  '  ,
        diff     = '   ' ,
        remotion = '  '  ,
        engine   = '   ' ,
        git      = '  '  ,
    }

    local function provider(name)
        return require('galaxyline.providers.' .. name)
    end

    local function str(args)
        return function() return args end
    end

    local function mode(field)
        local current_mode = fn.mode()
        return mode_colors[current_mode:byte()][field]
    end

    local functions             = require('functions').statusline
-- @UTILS]]






-- [[@PROVIDERS
    local buffer     = provider('buffer')
    local diagnostic = provider('diagnostic')
    local extension  = provider('extensions') -- plugins
    local fileinfo   = provider('fileinfo')
    local lspclient  = provider('lsp')
    local search     = provider('search')
    local vcs        = provider('vcs')        -- version control
    local whitespace = provider('whitespace')
    local gps        = require('nvim-gps')    -- treesitter context
-- @PROVIDERS]]






gl.short_line_list = { 'NvimTree', 'packer' }


gls.left[1] = {
    FirstElement = {
        provider  = str(icons.bar),
        highlight = { colors.blue, colors.blue },
    },
}

gls.left[2] = {
    MainIcon = {
        provider            = str(icons.main),
        highlight           = { colors.bg_dark, colors.blue },
        separator           = icons.right,
        separator_highlight = { colors.blue, colors.bg_light },
    },
}

gls.left[3] = {
    FileIcon = {
        provider  = 'FileIcon',
        condition = condition.buffer_not_empty,
        highlight = { colors.fg_dark, colors.bg_light },
    },
}

gls.left[4] = {
    FileName = {
        provider = function()
            return (api.nvim_buf_get_name(0):len() == 0)
            and icons.empty
            or fileinfo.get_current_file_name("", "")
        end,
        highlight = { colors.fg, colors.bg_light },
        separator = icons.right,
        separator_highlight = { colors.bg_light, colors.bg },
    },
}

gls.left[6] = {
    CurrentDir = {
        provider = function()
            local dir_name = functions.get_current_files_dir()
            return icons.dir .. dir_name .. ' '
        end,
        highlight = { colors.fg_dark, colors.bg },
        separator = icons.right,
        separator_highlight = { colors.bg, colors.bg_dark },
    },
}

--[[
    gls.left[7] = {
        DiffAdd = {
            provider = 'DiffAdd',
            icon = icons.addition,
            highlight = { colors.off_white, colors.bg_dark },
        },
    }

    gls.left[8] = {
        DiffModified = {
            provider = 'DiffModified',
            icon = icons.diff,
            highlight = { colors.fg, colors.bg_dark },
        },
    }

    gls.left[9] = {
        DiffRemove = {
            provider = 'DiffRemove',
            icon = icons.remotion,
            highlight = { colors.fg, colors.bg_dark },
        },
    }
]]--

gls.left[10] = {
    DiagnosticError = {
        provider = 'DiagnosticError',
        icon = icons.error,
        highlight = { colors.red, colors.bg_dark },
    },
}

gls.left[11] = {
    DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = icons.warning,
        highlight = { colors.yellow, colors.bg_dark },
    },
}

gls.left[12] = {
    TreeSitterContext = {
        provider = gps.get_location,
        condition = function()
            return condition.hide_in_width() and gps.is_available()
        end,
        highlight = { colors.fg_dark, colors.bg_dark },
    },
}

gls.right[1] = {
    LspStatus = {
        provider = function()
            local buf_clients = lsp.buf_get_clients()
            return #buf_clients and (icons.engine .. 'LSP ') or ' '
        end,
        highlight = { colors.fg, colors.bg_dark },
    },
}

gls.right[2] = {
    GitIcon = {
        provider = str(icons.git),
        condition = condition.check_git_workspace,
        highlight = { colors.fg, colors.bg_light },
        separator = icons.left,
        separator_highlight = { colors.bg_light, colors.bg_dark },
    },
}

gls.right[3] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = condition.check_git_workspace,
        highlight = { colors.fg, colors.bg_light },
    },
}

gls.right[6] = {
    LeftArrow = {
        provider = str('  '),
        highlight = {
            colors.fg,
            condition.check_git_workspace()
            and colors.bg_light
            or colors.bg_dark,
        },
    },
}

gls.right[7] = {
    LeftRound = {
        provider = function()
            cmd("hi GalaxyLeftRound guifg=" .. mode('color'))
            return icons.left
        end,
        highlight = {
            "GalaxyViMode",
            condition.check_git_workspace()
                and colors.bg_light
                or colors.bg_dark,
        },
    },
}

gls.right[8] = {
    ViModeIcon = {
        provider = function()
            cmd("hi GalaxyViModeIcon guibg=" .. mode('color'))
            return icons.vi_mode
        end,
        highlight = { colors.blacker, colors.red },
    },
}

gls.right[9] = {
    ViMode = {
        provider = function()
            cmd("hi GalaxyViMode guifg=" .. mode('color'))
            return "  " .. mode('name') .. " "
        end,
        highlight = { "GalaxyViMode", colors.bg_light },
    },
}

gls.right[10] = {
    SomeRoundicon = {
        provider = str(icons.position),
        separator = icons.left,
        separator_highlight = { colors.green, colors.bg_light },
        highlight = { colors.blacker, colors.green },
    },
}

gls.right[11] = {
    LinePercentage = {
        provider = functions.get_line_percentage,
        highlight = { colors.green, colors.bg_light },
    },
}

gls.right[12] = {
    ColRoundicon = {
        provider = str(icons.pos_col),
        separator = icons.left,
        separator_highlight = { colors.yellow, colors.bg_light },
        highlight = { colors.blacker, colors.yellow },
    },
}

gls.right[13] = {
    Column = {
        provider = function()
            local tbl = vim.api.nvim_win_get_cursor(0)
            return '  ' .. (tbl[2] + 1) .. ' '
        end,
        highlight = { colors.yellow, colors.bg_light },
    },
}







gls.short_line_left[1] = {
    FileIcon = {
        provider  = 'FileIcon',
        condition = condition.buffer_not_empty,
        highlight = { colors.fg_dark, colors.bg },
    },
}

gls.short_line_left[2] = {
    FileName = {
        provider = function()
            return (api.nvim_buf_get_name(0):len() == 0)
            and icons.empty
            or fileinfo.get_current_file_name()
        end,
        highlight = { colors.fg_dark, colors.bg },
    },
}

