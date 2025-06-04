require("nvim-surround").setup({
  keymaps = {
    insert = false,
    insert_line = false,
    normal = false,
    normal_cur = false,
    normal_line = false,
    normal_cur_line = false,
    visual = false,
    visual_line = false,
    delete = false,
    change = false,
    change_line = false,
  },
})

local utils = require("v.utils.mappings")

-- I don't have the slightest clue WHY, but without this it doesn't work ????
utils.unset_keybindings({
  { "n", "xss" },
  { "n", "xSS" },
})

utils.set_keybindings({
  { "n", "ds", "<Plug>(nvim-surround-delete)" },
  { "n", "cs", "<Plug>(nvim-surround-change)" },
  { "n", "cS", "<Plug>(nvim-surround-change-line)" },
  { "n", "xs", "<Plug>(nvim-surround-normal)", { nowait = false } },
  { "n", "xss", "<Plug>(nvim-surround-normal-cur)" },
  { "n", "xS", "<Plug>(nvim-surround-normal-line)", { nowait = false } },
  { "n", "xSS", "<Plug>(nvim-surround-normal-cur-line)" },
  { "x", "S", "<Plug>(nvim-surround-visual)" },
  { "x", "gS", "<Plug>(nvim-surround-visual-line)" },
})
