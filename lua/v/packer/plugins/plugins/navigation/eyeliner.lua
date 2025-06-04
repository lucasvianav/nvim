require("eyeliner").setup({
  highlight_on_key = true,
  dim = true,
  max_length = 240,
  disabled_filetypes = {
    "startify",
    "dashboard",
    "NvimTree",
    "NvimTree_*",
    "oil",
  },
  disabled_buftypes = {},
  default_keymaps = true,
})

local primary_hl_fg = vim.api.nvim_get_hl(0, { name = "EyelinerPrimary" }).fg
local secondary_hl_fg = vim.api.nvim_get_hl(0, { name = "EyelinerSecondary" }).fg

require("v.utils.highlights").set_highlights({
  {
    "EyelinerPrimary",
    { bold = true, underline = true, fg = primary_hl_fg },
  },
  {
    "EyelinerSecondary",
    { bold = true, fg = secondary_hl_fg },
  },
})
