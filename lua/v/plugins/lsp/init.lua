---@type LazyPluginSpec[]
local M = {
  -- config for language servers
  { "neovim/nvim-lspconfig" },

  -- TODO: consider swapping for L3MON4D3/LuaSnip
  -- cool snippet engine
  {
    "SirVer/ultisnips",
    event = "InsertEnter",
    commit = "dbc458e110bb49299da76ec53f8b09b4f6dce28a",
  },

  -- setup LSP for lua-nvim dev
  {
    "folke/lazydev.nvim",
    ft = "lua",
    name = "lazydev",
    commit = "2367a6c0a01eb9edb0464731cc0fb61ed9ab9d2c",
  },

  -- indicates code actions
  {
    "kosayoda/nvim-lightbulb",
    event = {
      "CursorHold",
      "CursorHoldI",
    },
    commit = "aa3a8b0f4305b25cfe368f6c9be9923a7c9d0805",
  },

  -- sql commands and code actions
  {
    "nanotee/sqls.nvim",
    ft = "sql",
    commit = "d1bc5421ef3e8edc5101e37edbb7de6639207a09",
  },

  -- show function signature
  -- ALT: https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
  {
    "ray-x/lsp_signature.nvim",
    event = { "CursorHoldI", "InsertEnter" },
    dependencies = "nvim-lspconfig",
    name = "lsp_signature",
    commit = "d50e40b3bf9324128e71b0b7e589765ce89466d2",
  },

  -- code completion + lsp-like functionalities without actual lsp
  -- DEPENDENCY: universal-ctags, ctags
  -- TODO: setup as fallback to lsp
  {
    "ludovicchabant/vim-gutentags",
    dependencies = "skywind3000/gutentags_plus",
    enabled = false,
    commit = "aa47c5e29c37c52176c44e61c780032dfacef3dd",
  },

  -- language server manager
  {
    "mason-org/mason.nvim",
    dependencies = {
      "nvim-lspconfig",
      { "mason-org/mason-lspconfig.nvim", version = "2.*" },
    },
    version = "2.*",
  },

  -- code completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "f3fora/cmp-spell",
        commit = "694a4e50809d6d645c1ea29015dad0c293f019d6",
      },
      {
        "hrsh7th/cmp-buffer",
        commit = "b74fab3656eea9de20a9b8116afa3cfc4ec09657",
      },
      {
        "hrsh7th/cmp-calc",
        commit = "5947b412da67306c5b68698a02a846760059be2e",
      },
      {
        "hrsh7th/cmp-cmdline",
        commit = "d126061b624e0af6c3a556428712dd4d4194ec6d",
      },
      {
        "hrsh7th/cmp-nvim-lsp",
        commit = "a8912b88ce488f411177fc8aed358b04dc246d7b",
      },
      {
        "hrsh7th/cmp-nvim-lua",
        commit = "f12408bdb54c39c23e67cab726264c10db33ada8",
      },
      {
        "hrsh7th/cmp-path",
        commit = "c6635aae33a50d6010bf1aa756ac2398a2d54c32",
      },
      {
        "lukas-reineke/cmp-under-comparator",
        version = "1.*",
      },
      {
        "onsails/lspkind-nvim",
        commit = "d79a1c3299ad0ef94e255d045bed9fa26025dab6",
      },
      {
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        commit = "f94f7ba948e32cd302caba1c2ca3f7c697fb4fcf",
      },
      {
        "xzbdmw/colorful-menu.nvim",
        commit = "bc3e82609f2fcf7dad7ca87c20e65e51d5d9d87c",
      },
    },
    event = { "InsertEnter", "CmdLineEnter" },
    commit = "b5311ab3ed9c846b585c0c15b7559be131ec4be9",
  },

  -- pretty list for lsp
  {
    "folke/trouble.nvim",
    dependencies = {
      "devicons",
      "nvim-lspconfig",
    },
    cmd = "Trouble",
    enabled = false,
    commit = "85bedb7eb7fa331a2ccbecb9202d8abba64d37b3",
  },

  -- html super snippets
  -- TODO: https://github.com/pedro757/emmet
  -- TODO: emmet_ls
  -- TODO: https://pbs.twimg.com/media/FC6NKbQWEAA6ZLc?format=jpg&name=4096x4096
  {
    "mattn/emmet-vim",
    ft = {
      "html",
      "vue",
      "javascript.jsx",
      "typescript.tsx",
    },
    enabled = false,
    commit = "6c511a8d7d2863066f32e25543e2bb99d505172cA",
  },

  -- like lsp but for debugging
  {
    "mfussenegger/nvim-dap",
    keys = {
      "<Leader>dL",
      "<Leader>db",
      "<Leader>dB",
      "<Leader>dc",
      "<Leader>de",
      "<Leader>di",
      "<Leader>do",
      "<Leader>dl",
      "<Leader>dt",
    },
    dependencies = {
      {
        "mxsdev/nvim-dap-vscode-js",
        lazy = true,
        dependencies = {
          {
            "microsoft/vscode-js-debug",
            lazy = true,
            build = "npm install --legacy-peer-deps && npm run compile",
          },
        },
      },
    },
    enabled = false,
    commit = "8df427aeba0a06c6577dc3ab82de3076964e3b8d",
  },

  {
    "creativenull/efmls-configs-nvim",
    lazy = true,
    commit = "e071a098ac1e56e349af649c25e982348f5504e5",
  },

  {
    "brexhq/kotlin-bazel.nvim",
    ft = "kotlin",
    enabled = v.env == "work",
    pin = true,
  },

  {
    "pmizio/typescript-tools.nvim",
    ft = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    commit = "3c501d7c7f79457932a8750a2a1476a004c5c1a9",
  },
}

return require("v.lazy.loader").process_plugins(M, "lsp")
