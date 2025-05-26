local pad = require("v.utils").pad_string_right

require("dashboard").setup({
  theme = "doom",
  hide = {
    statusline = true,
    tabline = true,
    winbar = true,
  },
  config = {
    -- colored icons
    header = require("v.utils.ascii").neovim_3,
    center = {
      {
        icon = pad("", 5),
        desc = pad("Find File", 10),
        keymap = "SPC f f",
      },
      {
        icon = pad("", 5),
        desc = pad("Grep", 10),
        keymap = "SPC f p",
      },
      {
        icon = pad("", 5),
        desc = pad("New File", 10),
        keymap = "CMD ene",
      },
      {
        icon = pad("", 5),
        desc = pad("Navigate Dotfiles", 10),
        keymap = "SPC f d",
      },
      {
        icon = pad("", 5),
        desc = pad("Navigate Neovim Settings", 10),
        keymap = "SPC f n",
      },
      {
        icon = pad("", 5),
        desc = pad("Exit Dashboard", 10),
        keymap = "q",
      },
    },
    footer = { "      " },
  },
})
