---@module "lazy.types"

---@type LazyPluginSpec[]
local M = {
  -- markdown lists
  {
    "dkarter/bullets.vim",
    ft = "markdown",
    version = "2.*",
  },

  -- kitty config
  {
    "fladson/vim-kitty",
    ft = "kitty",
    version = "1.*",
  },

  -- autodetect indent
  {
    "tpope/vim-sleuth",
    event = "BufEnter",
    commit = "be69bff86754b1aa5adcbb527d7fcd1635a84080",
  },

  -- package.json
  {
    "vuki656/package-info.nvim",
    event = "BufEnter package.json",
    opts = {},
    commit = "4f1b8287dde221153ec9f2acd46e8237d2d0881e",
  },

  -- better indenting in python
  {
    "Vimjas/vim-python-pep8-indent",
    ft = "python",
    commit = "60ba5e11a61618c0344e2db190210145083c91f8",
  },

  -- i3wm cofig file
  {
    "mboughaba/i3config.vim",
    ft = "i3config",
    commit = "5c753c56c033d3b17e5005a67cdb9653bbb88ba7",
  },

  -- code parsing for syntax highlighting, etc
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    -- TODO: update to main branch
    commit = "684eeac91ed8e297685a97ef70031d19ac1de25a",
  },

  -- JSON
  -- TODO: can this work with treesitter and LSP?
  -- TODO: also this https://github.com/akinsho/dotfiles/blob/main/.config/nvim/after/syntax/markdown.vim
  {
    "elzr/vim-json",
    enabled = false,
    ft = {
      "json",
      "jsonc",
      "jsonp",
    },
    commit = "3727f089410e23ae113be6222e8a08dd2613ecf2",
  },

  -- better commentstrings based in treesitter
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = "nvim-treesitter",
    event = "VeryLazy",
    opts = { enable_autocmd = false },
    commit = "1b212c2eee76d787bbea6aa5e92a2b534e7b4f8f",
  },

  -- autoclose and autoedit html tags
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascript",
      "javascript.jsx",
      "javascriptreact",
      "markdown",
      "php",
      "svelte",
      "typescript.tsx",
      "typescriptreact",
      "vue",
      "xml",
    },
    -- TODO: opts = {}, https://github.com/windwp/nvim-ts-autotag?tab=readme-ov-file#setup
    commit = "a1d526af391f6aebb25a8795cbc05351ed3620b5",
  },

  -- fix `gf` for some filetypes
  {
    "tpope/vim-apathy",
    ft = {
      "bash",
      "c",
      "cpp",
      "go",
      "javascript",
      "lua",
      "python",
      "sh",
      "shell",
      "typescript",
      "zsh",
    },
    commit = "27128a0f55189724c841843ba41cd33cf7186032",
  },

  -- split <-> join expressions
  {
    "Wansmer/treesj",
    keys = { "gS", "gJ", "g-" },
    commit = "3b4a2bc42738a63de17e7485d4cc5e49970ddbcc",
  },

  -- split <-> join expressions (fallback to treesj)
  {
    "AndrewRadev/splitjoin.vim",
    cmd = {
      "SplitjoinSplit",
      "SplitjoinJoin",
    },
    commit = "6af1cdcae4b46a90dbcd59ce0ca3543f34c7732c",
  },

  -- make % smarter
  {
    "andymass/vim-matchup",
    dependencies = "nvim-treesitter",
    commit = "56c714495ec7f40cf2c7e92fb124067c7951e650",
  },
}

return require("v.lazy.loader").process_plugins(M, "syntax")
