---@module "lazy.types"

---@type LazyPluginSpec[]
local M = {
  -- start screen
  {
    "glepnir/dashboard-nvim",
    cmd = {
      "Dashboard",
      "DashboardNewFile",
    },
    dependencies = "devicons",
    commit = "0f99b3cd66b9fde13926724c67c6e1abeb48e07d",
  },

  -- seamless navigation between neovim widows and tmux panes
  {
    "numToStr/Navigator.nvim",
    keys = {
      "<C-h>",
      "<C-j>",
      "<C-k>",
      "<C-l>",
    },
    cond = v.in_tmux,
    commit = "91d86506ac2a039504d5205d32a1d4bc7aa57072",
  },

  -- run commands in tmux pane from neovim
  {
    "preservim/vimux",
    cmd = {
      "VimuxPromptCommand",
      "VimuxRunLastCommand",
      "VimuxInspectRunner",
      "VimuxZoomRunner",
      "VimuxClearScreenHistory",
      "VimuxTogglePane",
    },
    keys = {
      "<Leader>tp",
      "<Leader>tr",
      "<Leader>ti",
      "<Leader>tz",
      "<Leader>tc",
      "<Leader>tt",
    },
    cond = v.in_tmux,
    commit = "7db6b2f79d432ee3820668b1d4625311dbe1d0ad",
  },

  -- nerdtree-like file explorer
  {
    "nvim-tree/nvim-tree.lua",
    name = "nvim-tree",
    dependencies = "devicons",
    cmd = {
      "NvimTreeToggle",
      "NvimTreeFindFile",
      "NvimTreeClose",
    },
    keys = "<Leader>e",
    version = "1.*",
  },

  -- highlight f/F and t/T targets
  {
    "jinh0/eyeliner.nvim",
    keys = { "f", "F", "t", "T" },
    commit = "8f197eb30cecdf4c2cc9988a5eecc6bc34c0c7d6",
  },

  -- fuzzy finder for lots of stuff
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "plenary.nvim",
      -- markdown header picker
      { "crispgm/telescope-heading.nvim",           ft = "markdown" },
      -- C sorter
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      "<Leader>ff",
      "<Leader>fh",
      "<Leader>fd",
      "<Leader>fr",
      "<Leader>fn",
      "<Leader>fk",
      "<Leader>fpk",
      "<Leader>ca",
      "<Leader>fpp",
      "<Leader>f/",
      "<Leader>fb",
      "<Leader>fg",
      "<Leader>fgg",
      "<Leader>fj",
      "<Leader>fch",
      "<Leader>fco",
      "gd",
      "grr",
      "gi",
      "z=",
    },
    commit = "b4da76be54691e854d3e0e02c36b0245f945c2c7",
  },

  {
    "ThePrimeagen/harpoon",
    dependencies = "plenary.nvim",
    keys = {
      "<leader><leader>h",
      "grh",
      "[H",
      "]H",
      "<m-h>",
      "<m-j>",
      "<m-k>",
      "<m-l>",
      "<c-s-h>",
      "<s-nl>",
      "<c-s-k>",
      "<c-s-l>",
    },
    cmd = "Harpoon",
    commit = "1bc17e3e42ea3c46b33c0bbad6a880792692a1b3",
  },

  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    keys = "-",
    commit = "685cdb4ffa74473d75a1b97451f8654ceeab0f4a",
  },

  -- 2-char search motion
  -- TODO: https://github.com/ggandor/leap.nvim
  -- TODO: https://github.com/folke/flash.nvim?tab=readme-ov-file
  {
    "ggandor/lightspeed.nvim",
    keys = { "<C-s>", "<C-S-s>" },
    commit = "fcc72d8a4d5f4ebba62d8a3a0660f88f1b5c3b05",
  },
}

return require("v.lazy.loader").process_plugins(M, "navigation")
