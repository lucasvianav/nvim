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
    disabled_filetypes = {
      "DiffviewFiles",
      "NvimTree",
      "qf",
      "terminal",
      "spectre_panel",
      "lazy",
      "dashboard",
      "gitcommit",
    },
  },
  sections = {
    lualine_a = {
      {
        "filename",
        fmt = function(filepath) --[[@param filepath string]]
          filepath = filepath:trim()
          local path = {}

          if #filepath == 0 then
            return utils.join(path)
          end

          local root, parts, dir_prefix = utils.get_path_parts(filepath)

          if dir_prefix then
            table.insert(path, dir_prefix)
          end

          if #parts == 0 then
            return utils.join(path)
          end

          if not root or parts[1] == root or #parts == 1 then
            return utils.join(path)
          end

          if root and parts[1] ~= root then
            table.insert(path, dir_prefix and "" or " ")
          end

          -- last element is the current file/dir (section c)
          -- and the previous one is its pwd (section b)
          local n_leading_dirs = #parts - 2

          if n_leading_dirs > 0 then
            -- TODO: make this dynamically change acceptable
            -- length depending on window width

            local length = #(dir_prefix or "")
            for i = 1, n_leading_dirs do
              if length > 25 and n_leading_dirs - i > 1 then
                break
              end
              table.insert(path, parts[i])
              length = length + #parts[i]
            end

            if #path - 2 < n_leading_dirs then
              table.insert(path, "-")
            end
          end

          return utils.join(path)
        end,
        path = 1,
        file_status = false,
        separator = { right = "" },
        padding = 0,
        draw_empty = true,
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
        fmt = function(filepath) --[[@param filepath string]]
          filepath = filepath:trim()
          local path = { "" }

          if #filepath == 0 then
            return utils.join(path)
          end

          local root, parts, is_dir = utils.get_path_parts(filepath)

          if #parts == 0 then
            return utils.join(path)
          end

          if not root and parts[1] ~= root then
            table.insert(path, 1, is_dir and "" or " ")
            table.insert(path, parts[1])
          elseif #parts == 1 then
            table.insert(path, 1, is_dir and "" or " ")
          else
            table.insert(path, parts[#parts - 1])
          end

          return utils.join(path)
        end,
        path = 1,
        file_status = false,
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
        fmt = function(filepath) --[[@param filepath string]]
          ---@diagnostic disable-next-line: redefined-local
          local filepath, tail = filepath:trim():match("^(%S+)(.*)$")
          local _, parts, is_dir = utils.get_path_parts(filepath)
          local path = {}

          if #parts == 0 then
            return utils.join({ is_dir and "" or " ", "" }) .. tail
          elseif #parts > 1 then
            table.insert(path, "")
          end

          table.insert(path, parts[#parts])

          if is_dir then
            table.insert(path, "")
          end

          return utils.join(path) .. tail
        end,
        path = 1,
        file_status = true,
        padding = { left = 0, right = 1 },
        color = { fg = colors.off_white, gui = "bold,italic" },
        symbols = {
          modified = "",
          readonly = "",
          unnamed = "[no name]",
        },
      },
    },
    lualine_c = {
      {
        "diagnostics",
        symbols = {
          error = " ",
          warn = " ",
          info = " ",
          hint = " ",
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
          local _, parts, prefix = utils.get_path_parts(filepath)
          return utils.join(table.merge_lists(prefix, "", "", parts))
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
