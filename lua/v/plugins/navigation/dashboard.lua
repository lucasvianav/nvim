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
        icon = pad("󰗼  ", 5),
        desc = pad("Exit Dashboard", 35),
        key = "<C-C>/q",
        action = function()
          vim.api.nvim_buf_delete(0, { unload = true, force = true })
        end,
      },
    },
    footer = { "      " },
  },
})
