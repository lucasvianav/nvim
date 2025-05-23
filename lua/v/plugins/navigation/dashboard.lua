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
        desc = pad("Find File", 40),
        keymap = "SPC f f",
        action = "Telescope find_files",
      },
      {
        icon = pad("", 5),
        desc = pad("Grep", 40),
        keymap = "SPC f p",
        action = "Telescope live_grep",
      },
      {
        icon = pad("", 5),
        desc = pad("New File", 40),
        keymap = "CMD ene",
        action = "DashboardNewFile",
      },
      {
        icon = pad("", 5),
        desc = pad("Navigate Dotfiles", 40),
        keymap = "SPC f d",
        action = function()
          require('v.plugins.navigation.telescope.searchers').find_dotfiles()
        end,
      },
      {
        icon = pad("", 5),
        desc = pad("Navigate Neovim Settings", 40),
        keymap = "SPC f n",
        action = function()
          require('v.plugins.navigation.telescope.searchers').find_nvim()
        end,
      },
    },
    footer = { "      " },
  },
})
