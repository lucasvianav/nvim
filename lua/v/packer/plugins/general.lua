-- TODO:
-- https://github.com/ThePrimeagen/refactoring.nvim
-- folke/twilight.nvim
-- https://github.com/nvim-neotest/neotest

local M = {
  -- packer can manage itself as an optional plugin
  {
    'wbthomason/packer.nvim',
    cmd = {
      'PackerClean',
      'PackerCompile',
      'PackerInstall',
      'PackerLoad',
      'PackerProfile',
      'PackerStatus',
      'PackerSync',
      'PackerUpdate',
    },
  },

  -- great utility lua functions
  {
    'nvim-lua/plenary.nvim',
    commit = '857c5ac632080dba10aae49dba902ce3abf91b35',
  },

  -- follow .editorconfig files
  {
    'editorconfig/editorconfig-vim',
    commit = '6a58b7c11f79c0e1d0f20533b3f42f2a11490cf8',
  },

  -- startup profiling
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    commit = 'b6f0d93f6b8cf6eee0b4c94450198ba2d6a05ff6',
  },

  -- displays a popup with keybindings
  {
    'folke/which-key.nvim',
    event = {
      'CursorHold',
      'CursorMoved',
    },
    commit = '370ec46f710e058c9c1646273e6b225acf47cbed',
  },

  -- lua documentation in :help
  {
    'milisims/nvim-luaref',
    ft = 'lua',
    commit = '9cd3ed50d5752ffd56d88dd9e395ddd3dc2c7127',
  },

  -- enables . repeat for plugins
  {
    'tpope/vim-repeat',
    keys = '.',
    fn = 'repeat#set',
    commit = '65846025c15494983dafe5e3b46c8f88ab2e9635',
  },

  -- auto pairs for {[()]}
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    commit = '4d74e75913832866aa7de35e4202463ddf6efd1b',
  },

  -- better <Esc> with jk
  {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    commit = '9738a470d93e2e52815bc46b4042372ca198cbd6',
  },

  -- provides great new text objects
  {
    'wellle/targets.vim',
    event = {
      'CursorHold',
      'CursorMoved',
    },
    commit = '6325416da8f89992b005db3e4517aaef0242602e',
  },

  -- pairs of handy bracket maps
  {
    'tpope/vim-unimpaired',
    event = {
      'CursorHold',
      'CursorMoved',
    },
    keys = {
      '[',
      ']',
      '<M-k>',
      '<M-j>',
      '<Space><Space>',
      'yo',
    },
    commit = '6d44a6dc2ec34607c41ec78acf81657248580bf1',
  },

  -- use nvim in the browser
  -- TODO: make this work pls
  {
    'glacambre/firenvim',
    run = function()
      vim.fn['firenvim#install'](0)
    end,
    disable = true,
    commit = 'c4ab7d2aeb145cd93db8660cb134f771722f2b5e',
  },

  -- session manager
  {
    'rmagatti/auto-session',
    event = 'VimLeavePre',
    cmd = {
      'SessionSave',
      'SessionRestore',
      'SessionDelete',
    },
    keys = { '<Leader>fs' },
    commit = '00334ee24b9a05001ad50221c8daffbeedaa0842',
  },

  -- like tpope/vim-surround but for functions
  {
    'AndrewRadev/dsf.vim',
    after = 'vim-surround',
    keys = {
      'csf',
      'dsf',
      'dif',
      'daf',
      'dsnf',
      { 'o', 'if' },
      { 'o', 'af' },
    },
    commit = 'b88e64d0987ab3ad7e7aebf94ded656d70c924e3',
  },

  -- surrounding manipulatiuon maps
  {
    'tpope/vim-surround',
    after = 'vim-repeat',
    event = { 'CursorMoved', 'CursorHold' },
    commit = '3d188ed2113431cf8dac77be61b842acb64433d9',
  },

  -- word manipulation utilities
  {
    'tpope/vim-abolish',
    cmd = { 'Abolish', 'Subvert' },
    keys = 'cr',
    after = 'vim-repeat',
    commit = 'dcbfe065297d31823561ba787f51056c147aa682',
  },

  -- maps for toggling comments
  -- TODO: swap for numToStr/Comment.nvim
  -- TODO: https://www.reddit.com/r/neovim/comments/q6lq5o/commentnvim_features_go_brrrrr/hgcxcok/?utm_source=reddit&utm_medium=web2x&context=3
  -- https://www.reddit.com/r/neovim/comments/r15nzf/commentnvim_3_treesitter_and_some_new_chef_kiss/
  {
    'tpope/vim-commentary',
    cmd = { 'Comment', 'Commentary' },
    keys = { 'gc', { 'v', 'gc' } },
    commit = '64a654ef4a20db1727938338310209b6a63f60c9',
  },

  -- align blocks of code
  -- ALTERNATIVE: vim-tabular
  {
    'junegunn/vim-easy-align',
    cmd = 'EasyAlign',
    keys = '<Leader>a',
    commit = '9815a55dbcd817784458df7a18acacc6f82b1241',
  },

  -- better clipboard
  {
    'svermeulen/vim-easyclip',
    event = { 'CursorMoved', 'InsertEnter' },
    after = 'vim-repeat',
    commit = '4601faae051bec8ced37b452b32defca62a633f3',
  },

  -- TSDoc docstrings generation
  -- ALTERNATIVE: TODO: kkoomen/vim-doge
  {
    'heavenshell/vim-jsdoc',
    cmd = { 'JsDoc', 'JsDocFormat' },
    keys = '<Leader>j',
    run = 'make install',
    commit = '6e5bc2a1f98a69e4902081c9f5969b228a7a5fd6',
  },

  -- 2-char search motion
  {
    'ggandor/lightspeed.nvim',
    keys = { '<C-s>', '<C-S-s>' },
    commit = 'fcc72d8a4d5f4ebba62d8a3a0660f88f1b5c3b05',
  },

  -- pulse cursorline after search (easier to find the cursor)
  {
    'inside/vim-search-pulse',
    keys = {
      '/',
      '?',
      'n',
      'N',
      '*',
      '#',
    },
    commit = '006934330dc9eab47a09eeee4c8a50a9b4c065b8',
  },

  -- custom "indent block" text object
  {
    'kana/vim-textobj-indent',
    requires = { 'kana/vim-textobj-user' },
    event = 'CursorMoved',
    commit = 'deb76867c302f933c8f21753806cbf2d8461b548',
  },

  -- markdown previewer in browser
  -- DEPENDENCY: npm
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    run = 'npm install && cd app && npm install',
    commit = 'a923f5fc5ba36a3b17e289dc35dc17f66d0548ee',
  },

  {
    'frabjous/knap',
    ft = { 'tex', 'plaintex' },
    commit = '7db44d0bb760120142cc1e8f43e44976de59c2f6',
  },

  -- project-wide search and replace
  -- DEPENDENCY: RG, sed
  {
    'windwp/nvim-spectre',
    after = 'plenary.nvim',
    keys = {
      '<Leader>S',
      { 'v', '<Leader>S' },
    },
    commit = '197150cd3f30eeb1b3fd458339147533d91ac385',
  },

  -- exchange motions
  -- ALTERNATIVE: mizlan/iswap.nvim
  {
    'tommcdo/vim-exchange',
    keys = {
      'cx',
      'cxx',
      'cxc',
      { 'v', 'X' },
    },
    commit = 'd6c1e9790bcb8df27c483a37167459bbebe0112e',
  },

  {
    'untitled-ai/jupyter_ascending.vim',
    event = 'BufEnter *.sync.py',
    disable = true,
    commit = '8b0f533fbf7f48d12feddedc10b78c53afa41bc2',
  },
}

return M
