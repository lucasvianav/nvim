require("v.utils.mappings").set_keybindings({
  { "n", "<Leader>gd", "<cmd>Gvdiffsplit!<CR>" },
  { "n", "<Leader>gh", "<cmd>diffget //2<CR>" },
  { "n", "<Leader>gl", "<cmd>diffget //3<CR>" },
  { "n", "<Leader>ga", "<cmd>Git add %<CR>" },
  { { "n", "v" }, "<Leader>gg", ":GBrowse<CR>" },
})
