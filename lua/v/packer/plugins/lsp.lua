-- ok so there's not only lsp stuff in here
-- there's all kind of completion-related plugins

local M = {
  { 'neovim/nvim-lspconfig' }, -- config for language servers

  -- TODO: consider swapping for L3MON4D3/LuaSnip
  { 'SirVer/ultisnips', event = 'InsertEnter' }, -- cool snippet engine
  { 'folke/neodev.nvim', ft = 'lua', as = 'neodev' }, -- setup LSP for lua-nvim dev
  { 'kosayoda/nvim-lightbulb', event = 'CursorHold' }, -- indicates code actions
  { 'nanotee/sqls.nvim', ft = 'sql' }, -- sql commands and code actions

  -- show function signature
  {
    'ray-x/lsp_signature.nvim',
    event = 'CursorHold',
    after = 'nvim-lspconfig',
  },

  -- nice code actions
  {
    'weilbith/nvim-code-action-menu',
    key = '<leader>ca',
    disable = true,
  },

  -- code completion + lsp-like functionalities without actual lsp
  -- DEPENDENCY: universal-ctags, ctags
  {
    'ludovicchabant/vim-gutentags',
    requires = 'skywind3000/gutentags_plus',
    disable = true,
  },

  -- easier way to install language servers
  {
    'williamboman/mason.nvim',
    after = 'nvim-lspconfig',
    requires = {
      { "williamboman/mason-lspconfig.nvim" }
    }
  },

  -- code completion
  {
    'hrsh7th/nvim-cmp',
    requires = {
      { 'f3fora/cmp-spell', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-calc', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },

      {
        'lukas-reineke/cmp-under-comparator',
        event = {
          'CursorHold',
          'CursorMoved',
        },
      },
      {
        'onsails/lspkind-nvim',
        event = {
          'CursorHold',
          'CursorMoved',
        },
      },
    },
    event = { 'InsertEnter', 'CmdLineEnter' },
  },

  -- pretty list for lsp
  {
    'folke/trouble.nvim',
    after = {
      'devicons',
      'nvim-lspconfig',
      'nvim-lspinstall',
    },
    cmd = 'Trouble',
    disable = true,
  },

  -- html super snippets
  -- TODO: https://github.com/pedro757/emmet
  -- TODO: emmet_ls
  -- TODO: https://pbs.twimg.com/media/FC6NKbQWEAA6ZLc?format=jpg&name=4096x4096
  {
    'mattn/emmet-vim',
    ft = {
      'html',
      'vue',
      'javascript.jsx',
      'typescript.tsx',
    },
  },
}

return M
