-- TODO: https://www.reddit.com/r/neovim/comments/qatokl/using_nvim_as_mergetool_with_vimfugitive/

require("v.utils.mappings").set_keybindings({
  { "n", "<Leader>gd", "<cmd>Gvdiffsplit!<CR>" },
  { "n", "<Leader>gh", "<cmd>diffget //2<CR>" },
  { "n", "<Leader>gl", "<cmd>diffget //3<CR>" },
  { "n", "<Leader>ga", "<cmd>Git add %<CR>" },
  { { "n", "v" }, "<Leader>gg", ":GBrowse<CR>" },
  { { "n", "v" }, "<leader>gy", ":GBrowse!<CR>" },
})
