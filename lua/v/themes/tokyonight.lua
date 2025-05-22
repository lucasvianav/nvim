require("tokyonight").setup({
  style = "storm", -- storm, moon, night
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { italic = false },
    variables = { italic = false },
    sidebars = "dark", -- dark, transparent, normal
    floats = "dark", -- dark, transparent, normal
  },
  sidebars = {
    "qf",
    "NvimTree",
    "NvimTree_*",
    "terminal",
    "packer",
    "spectre_panel",
  },
  hide_inactive_statusline = false,
  dim_inactive = false,
  lualine_bold = false,
})
