local set_keybindings = require("v.utils.mappings").set_keybindings

set_keybindings({
  -- toggle last visited buffer
  { "n", "<BS>", "<C-^>" },

  -- toggle last visited tab
  { "n", "<M-BS>", "g<Tab>" },

  -- better window navigation
  { "n", "<C-h>", "<C-w>h" },
  { "n", "<C-j>", "<C-w>j" },
  { "n", "<C-k>", "<C-w>k" },
  { "n", "<C-l>", "<C-w>l" },

  -- better nav for omnicomplete
  { { "c", "i" }, "<C-j>", "<C-n>" },
  { { "c", "i" }, "<C-k>", "<C-p>" },
})
