local pad = require("v.utils").pad_string_right

require("dashboard").setup({
  theme = "doom",
  hide = {
    statusline = true,
    tabline = true,
    winbar = true,
  },
  config = {
    header = require("v.utils.ascii").neovim_3,
    center = {
      {
        icon = pad("  ", 5),
        desc = pad("Find File", 35),
        key = "SPC f f",
        action = function()
          require("v.plugins.navigation.telescope.pickers").find_files_fd()
        end,
      },
      {
        icon = pad("󰺮  ", 5),
        desc = pad("Grep", 35),
        key = "SPC f p",
        action = function()
          require("v.plugins.navigation.telescope.pickers").multi_grep()
        end,
      },
      {
        icon = pad("󱓺  ", 5),
        desc = pad("New File", 35),
        key = "CMD ene",
        action = "DashboardNewFile",
      },
      {
        icon = pad("󱁤  ", 5),
        desc = pad("Navigate Dotfiles", 35),
        key = "SPC f d",
        action = function()
          require("v.plugins.navigation.telescope.searchers").find_dotfiles()
        end,
      },
      {
        icon = pad("  ", 5),
        desc = pad("Navigate Neovim Settings", 35),
        key = "SPC f n",
        action = function()
          require("v.plugins.navigation.telescope.searchers").find_nvim()
        end,
      },
      {
        icon = pad("󰊔  ", 5),
        desc = pad("Exit Dashboard", 35),
        key = "CTR c/q",
        action = require("v.plugins.navigation.dashboard.utils").quit_if_curr_buf,
      },
      {
        icon = pad("󰗼  ", 5),
        desc = pad("Exit Neovim", 35),
        key = "CMD qui",
        action = function()
          vim.api.nvim_exec2("qa", { output = false })
        end,
      },
    },
    footer = { "      " },
  },
})
