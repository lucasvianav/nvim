-- ok so there's not only actual syntax stuff in here
-- there's all kind of filetype-specific plugins

local M = {
  -- markdown lists
  {
    "dkarter/bullets.vim",
    ft = "markdown",
    commit = "8f3259e807c40b91d247f612823295ab99777a65",
  },

  -- kitty config
  {
    "fladson/vim-kitty",
    ft = { "kitty" },
    commit = "fd6df8b8396ffb7ea099dc6aecfbc7cf2bab0b2f",
  },

  -- LaTeX
  {
    "lervag/vimtex",
    ft = { "tex", "plaintex" },
    disable = true,
    commit = "85cb04f5a9d2289b9d2b62d5d84342fe9675ec08",
  },

  -- autodetect indent
  {
    "tpope/vim-sleuth",
    event = "CursorHold",
    commit = "be69bff86754b1aa5adcbb527d7fcd1635a84080",
  },

  -- package.json
  {
    "vuki656/package-info.nvim",
    ft = "json",
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

  -- TODO: https://github.com/jose-elias-alvarez/typescript.nvim
  -- TypeScript utilities
  {
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    ft = "typescript",
    commit = "0a6a16ef292c9b61eac6dad00d52666c7f84b0e7",
  },

  -- code parsing for syntax highlighting, etc
  {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    commit = "684eeac91ed8e297685a97ef70031d19ac1de25a",
  },

  -- highlight urls
  {
    "itchyny/vim-highlighturl",
    event = {
      "CursorHold",
      "CursorMoved",
    },
    commit = "7179156ccc68168e7ef8f1eae28edf36911f5a3c",
  },

  -- JSON
  -- TODO: can this work with treesitter and LSP?
  -- TODO: also this https://github.com/akinsho/dotfiles/blob/main/.config/nvim/after/syntax/markdown.vim
  {
    "elzr/vim-json",
    disable = true,
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
    as = "context-commentstring",
    after = { "vim-commentary", "nvim-treesitter" },
    commit = "1b212c2eee76d787bbea6aa5e92a2b534e7b4f8f",
  },

  -- autoclose and autoedit html tags
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "vue",
      "javascript.jsx",
      "javascriptreact",
      "typescript.tsx",
      "typescriptreact",
      "markdown",
    },
    commit = "a1d526af391f6aebb25a8795cbc05351ed3620b5",
  },

  -- fix `gf` for some filetypes
  {
    "tpope/vim-apathy",
    ft = {
      "go",
      "javascript",
      "typescript",
      "lua",
      "python",
      "c",
      "cpp",
    },
    commit = "27128a0f55189724c841843ba41cd33cf7186032",
  },

  -- single <-> multi-line
  {
    "AndrewRadev/splitjoin.vim",
    keys = { "gS", "gJ" },
    commit = "6af1cdcae4b46a90dbcd59ce0ca3543f34c7732c",
  },

  -- make % smarter
  {
    "andymass/vim-matchup",
    event = {
      "CursorHold",
      "CursorMoved",
    },
    keys = {
      "%",
      "g%",
      "[%",
      "]%",
      "z%",
    },
    after = "nvim-treesitter",
    commit = "ea2ff43e09e68b63fc6d9268fc5d82d82d433cb3",
  },

  -- highlight todo comments
  {
    "folke/todo-comments.nvim",
    event = { "BufRead" },
    after = "plenary.nvim",
    commit = "304a8d204ee787d2544d8bc23cd38d2f929e7cc5",
  },
}

return M
