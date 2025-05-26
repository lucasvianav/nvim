local M = {
  -- start screen
  {
    "glepnir/dashboard-nvim",
    cmd = {
      "Dashboard",
      "DashboardNewFile",
    },
    reuqires = "nvim-tree/nvim-web-devicons",
    commit = "b0551fae871fc39454a67cca1adcf76fbe2f61f9",
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
    cond = function()
      return vim.env.TMUX ~= nil
    end,
    commit = "91d86506ac2a039504d5205d32a1d4bc7aa57072",
  },

  -- nerdtree-like file explorer
  {
    "nvim-tree/nvim-tree.lua",
    as = "nvim-tree",
    after = "devicons",
    cmd = {
      "NvimTreeToggle",
      "NvimTreeFindFile",
      "NvimTreeClose",
    },
    keys = "<Leader>e",
    commit = "582ae48c9e43d2bcd55dfcc8e2e7a1f29065d924",
  },

  -- highlight f/F and t/T targets
  {
    "unblevable/quick-scope",
    as = "quickscope",
    keys = { "f", "F", "t", "T" },
    __opts = { setup = true },
    commit = "f2b6043e04d9ef05205c8953e389304a4c1946f2",
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
    cond = function()
      return vim.env.TMUX ~= nil
    end,
    commit = "7db6b2f79d432ee3820668b1d4625311dbe1d0ad",
  },

  -- fuzzy finder for lots of stuff
  {
    "nvim-telescope/telescope.nvim",
    after = "plenary.nvim",
    requires = {
      -- markdown header picker
      { "crispgm/telescope-heading.nvim" },

      -- C sorter
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },

      -- github and octo integration
      -- { 'nvim-telescope/telescope-github.nvim' },
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
      "<Leader>fs",
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
    commit = "a4ed82509cecc56df1c7138920a1aeaf246c0ac5",
  },

  {
    "ThePrimeagen/harpoon",
    after = "plenary.nvim",
    keys = {
      "<leader><leader>h",
      "grh",
      "[H",
      "]H",
      "<m-h>",
      "<m-j>",
      "<m-k>",
      "<m-l>",
      "<m-s-h>",
      "<m-s-j>",
      "<m-s-k>",
      "<m-s-l>",
    },
    cmd = {
      "Harpoon",
    },
    commit = "1bc17e3e42ea3c46b33c0bbad6a880792692a1b3",
  },
}

return M
