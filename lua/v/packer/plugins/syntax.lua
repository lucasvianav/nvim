-- ok so there's not only actual syntax stuff in here
-- there's all kind of filetype-specific plugins

local M = {
  { 'dkarter/bullets.vim', ft = 'markdown' }, -- markdown lists
  { 'fladson/vim-kitty', ft = { 'kitty' } }, -- kitty config
  { 'lervag/vimtex', ft = { 'tex', 'plaintex' } }, -- LaTeX
  { 'tpope/vim-sleuth', event = 'CursorHold' }, -- autodetect indent
  { 'vuki656/package-info.nvim', ft = 'json' }, -- package.json
  { 'Vimjas/vim-python-pep8-indent', ft = 'python' }, -- better indenting in python
  { 'mboughaba/i3config.vim', ft = 'i3config' }, -- i3wm cofig file

  { 'jose-elias-alvarez/nvim-lsp-ts-utils', ft = 'typescript' }, -- TypeScript utilities

  -- code parsing for syntax highlighting, etc
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    event = {
      'CursorHold',
      'CursorMoved',
    },
  },

  -- highlight urls
  {
    'itchyny/vim-highlighturl',
    event = {
      'CursorHold',
      'CursorMoved',
    },
  },

  -- better treesitter highlithing in angular
  {
    'nvim-treesitter/nvim-treesitter-angular',
    ft = {
      'typescript',
      'javascript',
      'html',
    },
    after = 'nvim-treesitter',
  },

  -- JSON
  -- TODO: can this work with treesitter and LSP?
  -- TODO: also this https://github.com/akinsho/dotfiles/blob/main/.config/nvim/after/syntax/markdown.vim
  {
    'elzr/vim-json',
    disable = true,
    ft = {
      'json',
      'jsonc',
      'jsonp',
    },
  },

  -- better commentstrings based in treesitter
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    as = 'context-commentstring',
    after = { 'vim-commentary', 'nvim-treesitter' },
  },

  -- autoclose and autoedit html tags
  {
    'windwp/nvim-ts-autotag',
    ft = {
      'html',
      'vue',
      'javascript.jsx',
      'javascriptreact',
      'typescript.tsx',
      'typescriptreact',
      'markdown',
    },
  },

  -- fix `gf` for some filetypes
  {
    'tpope/vim-apathy',
    ft = {
      'go',
      'javascript',
      'typescript',
      'lua',
      'python',
      'c',
      'cpp',
    },
  },
}

return M
