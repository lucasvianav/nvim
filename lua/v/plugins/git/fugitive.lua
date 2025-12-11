-- TODO: https://www.reddit.com/r/neovim/comments/qatokl/using_nvim_as_mergetool_with_vimfugitive/

require("v.utils.mappings").set_keybindings({
  { "n", "<Leader>gd", "<cmd>Gvdiffsplit!<CR>" },
  { "n", "<Leader>gh", "<cmd>diffget //2<CR>" },
  { "n", "<Leader>gl", "<cmd>diffget //3<CR>" },
  { { "n", "v" }, "<Leader>gg", ":GBrowse<CR>" },
  { { "n", "v" }, "<leader>gy", ":GBrowse!<CR>" },
})

require("v.utils.abbreviations").set_abbreviations({
  { { "GS", "gs" }, "Git status" },
  { { "GA", "ga" }, "Git add" },
  { { "GR", "gr" }, "Git restore" },
  { { "GAA", "gaa" }, "Git add --all" },
  { { "GCM", "gcm" }, "Git commit -m" },
  { "gcamne", "Git commit --amend --no-edit" },
  { { "GCK", "gck" }, "Git checkout" },
  { { "GPL", "gpl" }, "Git pull" },
}, "c")
