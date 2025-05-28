require("v.utils.mappings").set_keybindings({
  -- alt + shift + hjkl to resize windows
  { "n", "<m-s-j>", "2<C-w>-" },
  { "n", "<m-s-k>", "2<C-w>+" },
  { "n", "<m-s-h>", "2<C-w><" },
  { "n", "<m-s-l>", "2<C-w>>" },

  -- { "n", "<m-l>", "<c-w>L" },
  -- { "n", "<m-h>", "<c-w>H" },
  -- { "n", "<m-j>", "<c-w>J" },
  -- { "n", "<m-k>", "<c-w>K" },

  -- split  windows
  { "n", "<leader>h", "<C-w>s" },
  { "n", "<leader>v", "<C-w>v" },

  -- split  tabs
  { "n", "<leader>t", "<cmd>tab split<cr>" },
})
