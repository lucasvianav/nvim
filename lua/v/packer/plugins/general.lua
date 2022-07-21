-- TODO:
-- https://github.com/ThePrimeagen/refactoring.nvim
-- https://github.com/mfussenegger/nvim-dap
-- folke/twilight.nvim

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

  -- TODO: doesn't work for some reason
  -- { 'nathom/filetype.nvim' }, -- faster filetype detection

  -- TODO: use {'lewis6991/impatient.nvim', rocks = 'mpack'}
  { 'lewis6991/impatient.nvim' }, -- improve startup time
  { 'antoinemadec/FixCursorHold.nvim' }, -- fixes CursorHold and CursorHoldl
  { 'nvim-lua/plenary.nvim' }, -- great utility lua functions
  { 'editorconfig/editorconfig-vim' }, -- follow .editorconfig files

  { 'chrisbra/NrrwRgn', cmd = { 'NR', 'NUD' } }, -- focus narrow code section
  { 'dstein64/vim-startuptime', cmd = 'StartupTime' }, -- startup profiling
  { 'folke/which-key.nvim', event = 'CursorHold' }, -- displays a popup with keybindings
  { 'max397574/better-escape.nvim', event = 'InsertEnter' }, -- better <Esc> with jk
  { 'milisims/nvim-luaref', ft = 'lua' }, -- lua documentation in :help
  { 'tpope/vim-repeat', keys = '.', fn = 'repeat#set' }, -- enables . repeat for plugins
  { 'windwp/nvim-autopairs', event = 'InsertEnter' }, -- auto pairs for {[()]}

  -- provides great new text objects
  {
    'wellle/targets.vim',
    event = {
      'CursorHold',
      'CursorMoved',
    },
  },

  -- single <-> multi-line
  {
    'AndrewRadev/splitjoin.vim',
    keys = { 'gS', 'gJ' },
    event = {
      'CursorHold',
      'CursorMoved',
    },
  },

  -- make % smarter
  {
    'andymass/vim-matchup',
    event = {
      'CursorHold',
      'CursorMoved',
    },
    keys = {
      '%',
      'g%',
      '[%',
      ']%',
      'z%',
    },
  },

  -- pairs of handy bracket maps
  {
    'tpope/vim-unimpaired',
    keys = {
      '[',
      ']',
      '<M-k>',
      '<M-j>',
      '<Space><Space>',
      'yo',
    },
  },

  -- use nvim in the browser
  -- TODO: make this work pls
  {
    'glacambre/firenvim',
    run = function()
      vim.fn['firenvim#install'](0)
    end,
    disable = true,
  },

  -- session manager
  {
    'rmagatti/auto-session',
    event = 'VimLeavePre',
    cmd = {
      'SaveSession',
      'RestoreSession',
      'DeleteSession',
    },
    keys = { '<Leader>fs' },
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
  },

  -- surrounding manipulatiuon maps
  {
    'tpope/vim-surround',
    after = 'vim-repeat',
    event = { 'CursorMoved', 'CursorHold' },
  },

  -- word manipulation utilities
  {
    'tpope/vim-abolish',
    cmd = { 'Abolish', 'Subvert' },
    keys = 'cr',
    after = 'vim-repeat',
  },

  -- maps for toggling comments
  -- TODO: swap for numToStr/Comment.nvim
  -- TODO: https://www.reddit.com/r/neovim/comments/q6lq5o/commentnvim_features_go_brrrrr/hgcxcok/?utm_source=reddit&utm_medium=web2x&context=3
  -- https://www.reddit.com/r/neovim/comments/r15nzf/commentnvim_3_treesitter_and_some_new_chef_kiss/
  {
    'tpope/vim-commentary',
    cmd = { 'Comment', 'Commentary' },
    keys = { 'gc', { 'v', 'gc' } },
  },

  -- align blocks of code
  -- ALTERNATIVE: vim-tabular
  -- TODO: invest some time into this
  {
    'junegunn/vim-easy-align',
    cmd = 'EasyAlign',
    keys = '<Leader>a',
  },

  -- better clipboard
  -- TODO: lua port
  -- https://github.com/AckslD/nvim-neoclip.lua
  -- https://github.com/bfredl/nvim-miniyank
  {
    'svermeulen/vim-easyclip',
    event = { 'CursorMoved', 'InsertEnter' },
    after = 'vim-repeat',
  },

  -- TSDoc docstrings generation
  -- ALTERNATIVE: TODO: kkoomen/vim-doge
  {
    'heavenshell/vim-jsdoc',
    cmd = { 'JsDoc', 'JsDocFormat' },
    keys = '<Leader>j',
    run = 'make install',
  },

  -- 2-char search motion
  {
    'ggandor/lightspeed.nvim',
    keys = { '<C-s>', '<C-S-s>' },
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
  },

  -- custom "indent block" text object
  {
    'kana/vim-textobj-indent',
    requires = { 'kana/vim-textobj-user' },
    event = 'CursorMoved',
  },

  -- markdown previewer in browser
  -- DEPENDENCY: npm
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    run = 'npm install && cd app && npm install',
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
  },
}

return M
