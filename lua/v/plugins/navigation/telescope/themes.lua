local M = {}

local themes = require("telescope.themes")

M.center_dropdown = themes.get_dropdown({
  previewer = false,
  layout_strategy = "center",
})

M.ivy = themes.get_ivy({})

return M
