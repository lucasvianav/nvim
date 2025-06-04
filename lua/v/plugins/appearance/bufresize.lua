local opts = { noremap = true, silent = true }

require("bufresize").setup({
  register = {
    keys = {
      { "n", "<C-w><", "<C-w><", opts },
      { "n", "<C-w>>", "<C-w>>", opts },
      { "n", "<C-w>+", "<C-w>+", opts },
      { "n", "<C-w>-", "<C-w>-", opts },
      { "n", "<C-w>_", "<C-w>_", opts },
      { "n", "<C-w>=", "<C-w>=", opts },
      { "n", "<C-w>|", "<C-w>|", opts },
    },
    trigger_events = {
      "BufWinEnter",
      "WinEnter",
      "VimEnter",
    },
  },
  resize = {
    keys = {},
    trigger_events = { "VimResized" },
  },
})

local cmd = [[<cmd>lua require('bufresize').register()<cr>]]
require("v.utils.mappings").set_keybindings({
  { "n", "<m-s-j>", "2<C-w>-" .. cmd },
  { "n", "<m-s-k>", "2<C-w>+" .. cmd },
  { "n", "<m-s-h>", "2<C-w><" .. cmd },
  { "n", "<m-s-l>", "2<C-w>>" .. cmd },
})
