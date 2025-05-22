local g = vim.g

g.surround_no_mappings = true
g.surround_no_insert_mappings = true

require("v.utils.mappings").set_keybindings({
  { "n", "ds", "<Plug>Dsurround" },
  { "n", "cs", "<Plug>Csurround" },
  { "n", "cS", "<Plug>CSurround" },
  { "n", "xss", "<Plug>Yssurround" },
  { "n", "xSs", "<Plug>YSsurround" },
  { "n", "xSS", "<Plug>YSsurround" },
  { "n", "xs", "<Plug>Ysurround", { nowait = false } },
  { "n", "xS", "<Plug>YSurround", { nowait = false } },
  { "x", "S", "<Plug>VSurround" },
  { "x", "gS", "<Plug>VgSurround" },
})
