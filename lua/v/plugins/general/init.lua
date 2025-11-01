---@module "lazy.types"

-- TODO: https://github.com/nvimtools/hydra.nvim

---@type LazyPluginSpec[]
local M = {
  -- utility lua functions
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
    commit = "857c5ac632080dba10aae49dba902ce3abf91b35",
  },

  -- follow .editorconfig files
  {
    "editorconfig/editorconfig-vim",
    version = "1.*",
    event = "VeryLazy",
  },

  -- startup profiling
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    commit = "b6f0d93f6b8cf6eee0b4c94450198ba2d6a05ff6",
  },

  -- displays a popup with keybindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    enabled = false,
    version = "3.*",
  },

  -- lua documentation in :help
  {
    "milisims/nvim-luaref",
    ft = { "lua", "vim" },
    commit = "9cd3ed50d5752ffd56d88dd9e395ddd3dc2c7127",
  },

  -- enables . repeat for plugins
  {
    "tpope/vim-repeat",
    keys = ".",
    fn = "repeat#set",
    commit = "65846025c15494983dafe5e3b46c8f88ab2e9635",
  },

  -- auto pairs for {[()]}
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    commit = "4d74e75913832866aa7de35e4202463ddf6efd1b",
  },

  -- better <Esc> with jk
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    commit = "19a38aab94961016430905ebec30d272a01e9742",
  },

  -- provides great new text objects
  {
    "wellle/targets.vim",
    event = "VeryLazy",
    commit = "6325416da8f89992b005db3e4517aaef0242602e",
  },

  -- pairs of handy bracket maps
  {
    "tpope/vim-unimpaired",
    event = "VeryLazy",
    commit = "6d44a6dc2ec34607c41ec78acf81657248580bf1",
  },

  -- use nvim in the browser
  -- TODO: make this work pls
  {
    "glacambre/firenvim",
    build = function()
      vim.fn["firenvim#install"](0)
    end,
    enabled = false,
    commit = "c4ab7d2aeb145cd93db8660cb134f771722f2b5e",
  },

  -- session manager
  {
    "rmagatti/auto-session",
    event = "VimLeavePre",
    cmd = {
      "SessionSave",
      "SessionRestore",
      "SessionDelete",
    },
    commit = "00334ee24b9a05001ad50221c8daffbeedaa0842",
  },

  -- surrounding manipulation
  {
    "kylechui/nvim-surround",
    keys = {
      "cS",
      "cs",
      "ds",
      "xS",
      "xSS",
      "xs",
      "xss",
      { "S", mode = "x" },
      { "gS", mode = "x" },
    },
    version = "3.*",
  },

  -- word manipulation utilities
  {
    "tpope/vim-abolish",
    cmd = { "Abolish", "Subvert" },
    keys = "cr",
    dependencies = "vim-repeat",
    commit = "dcbfe065297d31823561ba787f51056c147aa682",
  },

  -- align blocks of code
  -- ALT: echasnovski/mini.align
  {
    "junegunn/vim-easy-align",
    cmd = "EasyAlign",
    keys = "<Leader>a",
    commit = "9815a55dbcd817784458df7a18acacc6f82b1241",
  },

  -- better clipboard
  {
    "svermeulen/vim-easyclip",
    event = "VeryLazy",
    dependencies = "vim-repeat",
    commit = "4601faae051bec8ced37b452b32defca62a633f3",
  },

  -- custom "indent block" text object
  {
    "kana/vim-textobj-indent",
    dependencies = "kana/vim-textobj-user",
    event = "VeryLazy",
    commit = "deb76867c302f933c8f21753806cbf2d8461b548",
  },

  -- markdown previewer in browser
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    commit = "a923f5fc5ba36a3b17e289dc35dc17f66d0548ee",
  },

  -- project-wide search and replace
  -- DEPENDENCY: RG, sed
  {
    "windwp/nvim-spectre",
    dependencies = "plenary.nvim",
    keys = {
      "<Leader>S",
      { "<Leader>S", mode = "v" },
    },
    commit = "72f56f7585903cd7bf92c665351aa585e150af0f",
  },

  -- exchange motions
  -- ALT: mizlan/iswap.nvim
  {
    "tommcdo/vim-exchange",
    keys = {
      "cx",
      "cxx",
      "cxc",
      { "X", mode = "v" },
    },
    commit = "d6c1e9790bcb8df27c483a37167459bbebe0112e",
  },

  -- improve vim.ui
  {
    "folke/snacks.nvim",
    event = "VeryLazy",
    commit = "bc0630e43be5699bb94dadc302c0d21615421d93",
  },

  -- normal mode in cmdline
  {
    "jake-stewart/normal-cmdline.nvim",
    event = "CmdlineEnter",
    commit = "efc83f5b1abc1398b8058e563fdd5e34a3652803",
  },

  -- visualize the tree of undo history
  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle", "UndotreeShow" },
    keys = "<leader>u",
    commit = "b951b87b46c34356d44aa71886aecf9dd7f5788a",
  },

  {
    "frabjous/knap",
    ft = { "tex", "plaintex" },
    commit = "7db44d0bb760120142cc1e8f43e44976de59c2f6",
  },
}

return require("v.lazy.loader").process_plugins(M, "general")
