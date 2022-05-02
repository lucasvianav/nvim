---Heavily inspired by:
---https://github.com/akinsho/dotfiles
---https://github.com/NvChad/NvChad

-- TODO: global statusline (+ 0.7 options)

local utils = require('v.utils.statusline')
local colors = require('v.utils.highlights').colors
local alter_color = require('v.utils.highlights').alter_color

local bubbles_theme = {
  normal = {
    a = { fg = colors.grey_light, bg = colors.grey_darker },
    b = { fg = colors.white, bg = colors.grey_darker },
    c = { fg = colors.black, bg = alter_color(colors.cyan_grey_dark, -25) },
    x = { fg = colors.white, bg = colors.grey_darker },
    y = { fg = colors.black, bg = colors.green },
    z = { fg = colors.white, bg = colors.grey_darker },
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
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      {
        'filename',
        fmt = function(str)
          if str == '' then
            return ' '
          end

          local cwd = utils.get_cwd()
          local dirs = utils.convert_path_to_list(str)

          if dirs[1] == cwd or #dirs == 1 then
            return ' '
          end

          local remaining = (#dirs > 2) and (dirs[1] .. '/-/') or ''
          return ' ' .. cwd .. '/' .. remaining
        end,
        path = 1,
        file_status = true,
        separator = { right = '' },
        padding = 0,
        symbols = {
          modified = '',
          readonly = '',
          unnamed = '',
        },
      },
    },
    lualine_b = {
      {
        'filename',
        fmt = function(str)
          if str == '' then
            return ''
          end

          local cwd = utils.get_cwd()
          local nodes = utils.convert_path_to_list(str)

          if nodes[1] == cwd or #nodes == 1 then
            return cwd .. '/'
          end

          return nodes[#nodes - 1] .. '/'
        end,
        path = 1,
        file_status = true,
        padding = 0,
        color = { fg = colors.green, gui = 'bold' },
        symbols = {
          modified = '',
          readonly = '',
          unnamed = '',
        },
      },
      {
        'filename',
        fmt = function(str)
          if str == '' then
            return ''
          end

          return str:gsub('.+%/([^/]+)$', '%1')
        end,
        path = 1,
        file_status = true,
        padding = { left = 0, right = 1 },
        color = { fg = colors.off_white, gui = 'bold,italic' },
        symbols = {
          modified = ' ',
          readonly = ' ',
          unnamed = '[No Name]',
        },
      },
    },
    lualine_c = {
      {
        'diagnostics',
        symbols = {
          error = '  ',
          warn = '  ',
          info = '  ',
          hint = '  ',
        },
      },
    },
    lualine_x = {
      {
        'branch',
        icon = { '', color = { fg = colors.yellow } },
        color = {
          fg = colors.off_white,
          bg = colors.cyan_grey,
          gui = 'bold',
        },
        separator = { left = '', right = '' },
      },
      {
        '" LSP"',
        cond = function()
          local buf_clients = vim.lsp.buf_get_clients()
          return #buf_clients > 0
        end,
        color = {
          fg = colors.cyan,
          bg = colors.cyan_grey_dark,
          gui = 'bold',
        },
        separator = { left = '', right = '' },
      },
      {
        'filetype',
        color = { fg = colors.white, bg = colors.grey_dark },
      },
    },
    lualine_y = { 'mode' },
    lualine_z = {
      {
        '"l"',
        color = { fg = colors.grey_light, gui = 'italic' },
      },
      {
        function()
          local curr, _ = utils.get_line_extremes()
          return curr
        end,
        color = { gui = 'bold' },
        padding = 0,
      },
      {
        function()
          local _, last = utils.get_line_extremes()
          return '/' .. last
        end,
        padding = { left = 0, right = 1 },
        color = { fg = colors.grey_light, gui = 'italic' },
      },
      {
        '"Co."',
        color = { fg = colors.grey_light, gui = 'italic' },
      },
      {
        'location',
        fmt = function(str)
          return str:sub(5) -- get col
        end,
        padding = { left = 0, right = 1 },
        color = { gui = 'bold' },
      },
    },
  },
  inactive_sections = {
    lualine_a = {
      {
        'filename',
        fmt = function(str)
          return str:gsub('(.+%/)[^/]+(%/[^/]+)$', '%1' .. utils.get_current_files_dir() .. '%2')
        end,
        path = 1,
      },
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})
