require("harpoon").setup({
  -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
  save_on_toggle = false,
  -- saves the harpoon file upon every change. disabling is unrecommended.
  save_on_change = true,
  -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
  enter_on_sendcmd = false,
  -- closes any tmux windows that harpoon creates when you close Neovim.
  tmux_autoclose_windows = false,
  -- filetypes that you want to prevent from adding to the harpoon list menu.
  excluded_filetypes = { "harpoon" },
  -- set marks specific to each git branch inside git repository
  mark_branch = false,
  -- enable tabline with harpoon marks
  tabline = false,
  menu = {
    width = 150,
  },
})

local telescope_ok, telescope = pcall(require, "telescope")

if not telescope_ok or not pcall(telescope.load_extension, "harpoon") then
  vim.notify("Failed to load Telescope extension.", vim.log.levels.ERROR, {
    title = "Harpoon",
  })
end

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

require("v.utils.mappings").set_keybindings({
  { "n", "grh", mark.toggle_file },
  { "n", "[H", ui.nav_prev },
  { "n", "]H", ui.nav_next },
  {
    "n",
    "<m-h>",
    function()
      ui.nav_file(1)
    end,
  },
  {
    "n",
    "<m-j>",
    function()
      ui.nav_file(2)
    end,
  },
  {
    "n",
    "<m-k>",
    function()
      ui.nav_file(3)
    end,
  },
  {
    "n",
    "<m-l>",
    function()
      ui.nav_file(4)
    end,
  },
  {
    "n",
    "<m-;>",
    function()
      ui.nav_file(5)
    end,
  },
  {
    "n",
    "<c-m-h>",
    function()
      mark.set_current_at(1)
    end,
  },
  {
    "n",
    "<m-nl>",
    function()
      mark.set_current_at(2)
    end,
  },
  {
    "n",
    "<c-m-k>",
    function()
      mark.set_current_at(3)
    end,
  },
  {
    "n",
    "<c-m-l>",
    function()
      mark.set_current_at(4)
    end,
  },
  {
    "n",
    "<c-m-;>",
    function()
      mark.set_current_at(5)
    end,
  },
  {
    "n",
    "<leader><leader>h",
    ui.toggle_quick_menu,
  },
})

require("v.utils.commands").command("Harpoon", "lua require(\"harpoon.ui\").toggle_quick_menu()")
require("v.utils.abbreviations").abbreviate("c", "H", "Harpoon")
