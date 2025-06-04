-- ok so there's not only lsp stuff in here
-- there's all kind of completion-related plugins

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
    as = "lazydev",
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
    commit = "d1bc5421ef3e8edc5101e37edbb7de6639207a09kA",
  },

  -- show function signature
  {
    "ray-x/lsp_signature.nvim",
    event = { "CursorHoldI", "InsertEnter" },
    after = "nvim-lspconfig",
    commit = "a793d02b6a5e639fa9d3f2a89a839fa688ab2d0aA",
    as = "lsp_signature",
  },

  -- code completion + lsp-like functionalities without actual lsp
  -- DEPENDENCY: universal-ctags, ctags
  {
    "ludovicchabant/vim-gutentags",
    requires = "skywind3000/gutentags_plus",
    disable = true,
    commit = "aa47c5e29c37c52176c44e61c780032dfacef3dd",
  },

  -- language server manager
  {
    "mason-org/mason.nvim",
    after = "nvim-lspconfig",
    requires = {
      {
        "mason-org/mason-lspconfig.nvim",
        commit = "d24b3f1612e53f9d54d866b16bedab51813f2bf1",
      },
    },
    commit = "8024d64e1330b86044fed4c8494ef3dcd483a67c",
  },

  -- code completion
  {
    "hrsh7th/nvim-cmp",
    requires = {
      { "f3fora/cmp-spell", after = "nvim-cmp" },
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
      { "hrsh7th/cmp-calc", after = "nvim-cmp" },
      { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
      {
        "lukas-reineke/cmp-under-comparator",
        event = {
          "CursorHold",
          "CursorMoved",
        },
      },
      {
        "onsails/lspkind-nvim",
        event = {
          "CursorHold",
          "CursorMoved",
        },
      },
    },
    event = { "InsertEnter", "CmdLineEnter" },
    commit = "b5311ab3ed9c846b585c0c15b7559be131ec4be9",
  },

  -- pretty list for lsp
  {
    "folke/trouble.nvim",
    after = {
      "devicons",
      "nvim-lspconfig",
      "nvim-lspinstall",
    },
    cmd = "Trouble",
    disable = true,
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
    requires = {
      {
        "mxsdev/nvim-dap-vscode-js",
        opt = true,
        requires = {
          {
            "microsoft/vscode-js-debug",
            opt = true,
            run = "npm install --legacy-peer-deps && npm run compile",
          },
        },
      },
    },
    commit = "8df427aeba0a06c6577dc3ab82de3076964e3b8d",
  },

  {
    "creativenull/efmls-configs-nvim",
    commit = "e071a098ac1e56e349af649c25e982348f5504e5",
    opt = true,
  },

  {
    "brexhq/kotlin-bazel.nvim",
    ft = { "kotlin" },
    disable = v.env ~= "work",
    lock = true,
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

return M
