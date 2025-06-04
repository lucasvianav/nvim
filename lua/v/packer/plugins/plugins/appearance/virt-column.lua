require("virt-column").setup({
  char = "│",
  highlight = "ColorColumn",
})

require("v.utils.highlights").highlight(
  "ColorColumn",
  { fg = require("v.utils").colors.cyan_grey_dark }
)
