require("tokyonight").setup({
  style = "storm", ---@type "storm"|"moon"|"night"
  light_style = "day",
  day_brightness = 0.3,
  transparent = false,
  terminal_colors = true,
  cache = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { italic = false },
    variables = { italic = false },
    sidebars = "dark", ---@type "dark"|"transparent"|"normal"
    floats = "dark", ---@type "dark"|"transparent"|"normal"
  },
  sidebars = {
    "qf",
    "NvimTree",
    "NvimTree_*",
    "terminal",
    "packer",
    "spectre_panel",
    "DiffviewFiles",
    "lazy",
  },
  hide_inactive_statusline = false,
  dim_inactive = false,
  lualine_bold = false,
  on_colors = function() end,
  on_highlights = function() end,
  plugins = {
    all = package.loaded.lazy == nil,
    auto = true,
  },
})
