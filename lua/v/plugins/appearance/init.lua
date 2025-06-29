---@module "lazy.types"

-- TODO: https://github.com/folke/noice.nvim

---@type LazyPluginSpec[]
local M = {
  -- low profile notifications (including for LSP progress)
  {
    "j-hui/fidget.nvim",
    version = "1.*",
  },

  -- beautiful notifications
  {
    "rcarriga/nvim-notify",
    version = "3.*",
    lazy = true, -- will be loaded by fidget.nvim
    keys = "<leader>fN",
    cmd = "Notifications",
  },

  -- preserve window sizes on terminal resize
  {
    "kwkarlwang/bufresize.nvim",
    commit = "3b19527ab936d6910484dcc20fb59bdb12322d8b",
  },

  -- display opened tabs (2+)
  -- TODO: maybe swap for my own tabline
  -- https://gitlab.com/yorickpeterse/dotfiles/-/blob/9b4aa6cf097015e156bbfa447f2324ece9a385ea/dotfiles/.config/nvim/lua/dotfiles/tabline.lua
  {
    "crispgm/nvim-tabline",
    commit = "287cd88157f98da76cb32ac7df7ec5c546414ec0",
    opts = {
      show_index = true, -- show tab index
      show_modify = true, -- show buffer modification indicator
      no_name = "[no name]", -- no name buffer name
    },
  },

  -- colored matching brackets
  {
    "hiphish/rainbow-delimiters.nvim",
    dependencies = "nvim-treesitter",
    main = "rainbow-delimiters.setup",
    opts = {},
    event = "VeryLazy",
    commit = "55ad4fb76ab68460f700599b7449385f0c4e858e",
  },

  -- colored icons
  {
    "nvim-tree/nvim-web-devicons",
    name = "devicons",
    lazy = true,
    commit = "1fb58cca9aebbc4fd32b086cb413548ce132c127",
  },

  -- colored color codes
  -- ALT: brenoprata10/nvim-highlight-colors
  {
    "catgoose/nvim-colorizer.lua",
    event = "VeryLazy",
    commit = "517df88cf2afb36652830df2c655df2da416a0ae",
  },

  -- indent lines
  {
    "lukas-reineke/indent-blankline.nvim",
    dependencies = "nvim-treesitter",
    event = "VeryLazy",
    version = "3.*",
  },

  -- colorcolumn with virtual text
  {
    "lukas-reineke/virt-column.nvim",
    enabled = not v.has("mac"), -- avoid highlighting issues on mac
    event = "VeryLazy",
    version = "2.*",
  },

  -- fancy statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "devicons" },
    commit = "0c6cca9f2c63dadeb9225c45bc92bb95a151d4af",
  },

  -- centralize buffer
  {
    "shortcuts/no-neck-pain.nvim",
    cmd = "NoNeckPain",
    keys = "<leader>nn",
    version = "2.*",
  },

  -- highlight urls
  {
    "itchyny/vim-highlighturl",
    event = "VeryLazy",
    commit = "7179156ccc68168e7ef8f1eae28edf36911f5a3c",
  },

  -- highlight todo comments
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = "plenary.nvim",
    commit = "304a8d204ee787d2544d8bc23cd38d2f929e7cc5",
  },

  -- pulse cursorline after search (easier to find the cursor)
  {
    "inside/vim-search-pulse",
    keys = { "/", "?", "n", "N", "*", "#" },
    commit = "006934330dc9eab47a09eeee4c8a50a9b4c065b8",
  },

  -- display images in neovim
  -- TODO: display it in telescope
  -- https://github.com/3rd/image.nvim/issues/183#issuecomment-2284979815
  -- https://github.com/3rd/image.nvim/issues/183#issuecomment-2574767246
  -- https://github.com/3rd/image.nvim/issues/183#issuecomment-2702160614
  {
    "3rd/image.nvim",
    opts = { processor = "magick_rock" },
    event = "VeryLazy",
    commit = "4c51d6202628b3b51e368152c053c3fb5c5f76f2",
  },
}

return require("v.lazy.loader").process_plugins(M, "appearance")
