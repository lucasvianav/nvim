require("v.utils.mappings").set_keybindings({
  -- alt + shift + hjkl to resize windows
  { "n", "<S-M-J>", "2<C-w>-" },
  { "n", "<S-M-K>", "2<C-w>+" },
  { "n", "<S-A-H>", "2<C-w><" },
  { "n", "<S-A-L>", "2<C-w>>" },

  -- split  windows
  { "n", "<leader>h", "<C-w>s" },
  { "n", "<leader>v", "<C-w>v" },

  -- split  tabs
  { "n", "<leader>t", "<cmd>tabedit %<cr>" },
})
