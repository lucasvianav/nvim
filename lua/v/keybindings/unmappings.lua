require("v.utils.mappings").unset_keybindings({
  { "n", "-" },
  { "n", "<CR>" },
  { "n", "<Space>" },
  { "n", "ZZ" },

  { { "n", "i" }, "<Up>" },
  { { "n", "i" }, "<Down>" },
  { { "n", "i" }, "<Right>" },
  { { "n", "i" }, "<Left>" },

  { { "i", "n", "o", "v", "x", "s" }, "<Esc>" },
})
