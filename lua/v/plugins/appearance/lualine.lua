---Heavily inspired by:
---https://github.com/akinsho/dotfiles
---https://github.com/NvChad/NvChad

--TODO: https://github.com/idr4n/nvim-lua/tree/master/lua/config/statusline

local utils = require("v.utils.statusline")
local colors = require("v.utils.highlights").colors
local alter_color = require("v.utils.highlights").alter_color

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
  command = { y = { fg = colors.black, bg = colors.pink_light } },
  inactive = {
    a = { fg = colors.cyan_grey, bg = colors.off_black },
    b = { fg = colors.cyan_grey, bg = colors.off_black },
    c = { fg = colors.off_black, bg = colors.off_black },
  },
}

require("lualine").setup({
  options = {
    theme = bubbles_theme,
    component_separators = "",
    section_separators = { left = "", right = "" },
    globalstatus = false,
  },
  sections = {
    lualine_a = {
      {
        "filename",
        fmt = function(filepath)
          local path = { "" }

          if #filepath == 0 then
            return vim.fs.joinpath(unpack(path))
          end

          local root, parts = utils.get_path_parts(filepath)

          if not root or parts[1] == root or #parts == 1 then
            return vim.fs.joinpath(unpack(path))
          end

          if root and parts[1] ~= root then
            table.insert(path, root)
          end
          if #parts > 3 then
            table.insert(path, parts[1])
            table.insert(path, parts[2])
            table.insert(path, "-")
          end

          return vim.fs.joinpath(unpack(path))
        end,
        path = 1,
        file_status = true,
        separator = { right = "" },
        padding = { left = 1, right = 0 },
        symbols = {
          modified = "",
          readonly = "",
          unnamed = "",
        },
      },
    },
    lualine_b = {
      {
        "filename",
        fmt = function(filepath)
          local path = { "" }

          if #filepath == 0 then
            return vim.fs.joinpath(unpack(path))
          end

          local root, parts = utils.get_path_parts(filepath)

          if #parts == 1 or (root and parts[1] == root) then
            table.insert(path, parts[1])
          else
            table.insert(path, parts[#parts - 1])
          end

          table.insert(path, "")
          return vim.fs.joinpath(unpack(path))
        end,
        path = 1,
        file_status = true,
        padding = 0,
        color = { fg = colors.green, gui = "bold" },
        symbols = {
          modified = "",
          readonly = "",
          unnamed = "",
        },
      },
      {
        "filename",
        fmt = vim.fs.basename,
        path = 1,
        file_status = true,
        padding = { left = 0, right = 1 },
        color = { fg = colors.off_white, gui = "bold,italic" },
        symbols = {
          modified = " ",
          readonly = " ",
          unnamed = "[No Name]",
        },
      },
    },
    lualine_c = {
      {
        "diagnostics",
        symbols = {
          error = "  ",
          warn = "  ",
          info = "  ",
          hint = "  ",
        },
      },
    },
    lualine_x = {
      {
        "branch",
        fmt = function(
          branch --[[@param branch string]]
        )
          if #branch > 30 then
            local basename = vim.fs.basename(branch)
            if #basename > 0 then
              return basename:sub(1, 15) .. "..." .. basename:sub(#basename - 15, #basename)
            end
            return basename
          end

          return branch
        end,
        icon = { "", color = { fg = colors.yellow } },
        color = {
          fg = colors.off_white,
          bg = colors.cyan_grey,
          gui = "bold",
        },
        separator = { left = "", right = "" },
      },
      {
        "\" LSP\"",
        cond = utils.buf_has_lsp_attached,
        color = {
          fg = colors.cyan,
          bg = colors.cyan_grey_dark,
          gui = "bold",
        },
        separator = { left = "", right = "" },
      },
      {
        "\"❇ EFM\"",
        cond = utils.buf_has_formatter_attached,
        color = {
          fg = colors.cyan,
          bg = alter_color(colors.cyan_grey_dark, -20),
          gui = "bold",
        },
        separator = { left = "", right = "" },
      },
      {
        "filetype",
        color = { fg = colors.white, bg = colors.grey_dark },
      },
    },
    lualine_y = { "mode" },
    lualine_z = {
      {
        "\"l\"",
        color = { fg = colors.grey_light, gui = "italic" },
      },
      {
        function()
          return vim.fn.line(".")
        end,
        color = { gui = "bold" },
        padding = 0,
      },
      {
        function()
          return "/" .. vim.fn.line("$")
        end,
        padding = { left = 0, right = 1 },
        color = { fg = colors.grey_light, gui = "italic" },
      },
      {
        function()
          return "(" .. utils.get_line_percentage() .. ")"
        end,
        padding = { left = 0, right = 1 },
        color = { fg = colors.grey_light, gui = "italic" },
      },
      {
        "\"Co.\"",
        color = { fg = colors.grey_light, gui = "italic" },
      },
      {
        "location",
        fmt = function(str)
          return str:sub(5) -- get col
        end,
        padding = { left = 0, right = 1 },
        color = { gui = "bold" },
      },
    },
  },
  inactive_sections = {
    lualine_a = {
      {
        "filename",
        fmt = function(filepath)
          local root, parts = utils.get_path_parts(filepath)
          return vim.fs.joinpath(unpack(table.merge_lists("", root or {}, parts)))
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
