local M = {
  { 'rcarriga/nvim-notify' }, -- beautiful notifications
  { 'kwkarlwang/bufresize.nvim' }, -- preserve window sizes on terminal resize
  { 'crispgm/nvim-tabline' }, -- display opened tabs (2+)
  { 'stevearc/dressing.nvim' }, -- improve vim.ui

  { 'kyazdani42/nvim-web-devicons', as = 'devicons' }, -- colored icons
  { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' }, -- colored matching brackets

  -- colored color codes
  -- DEPENDENCY: Golang
  {
    'RRethy/vim-hexokinase',
    event = 'CursorHold',
    run = 'make hexokinase',
  },

  -- indent lines
  {
    'lukas-reineke/indent-blankline.nvim',
    after = 'nvim-treesitter',
  },

  -- colorcolumn with virtual text
  {
    'lukas-reineke/virt-column.nvim',
    disable = true,
    event = {
      'CursorHold',
      'CursorMoved',
    },
  },

  -- fancy statusline
  {
    'nvim-lualine/lualine.nvim',
    after = { 'devicons' },
  },

  -- show cursor context in statusline
  {
    'SmiteshP/nvim-gps',
    after = 'nvim-treesitter',
    disable = true,
  },
}

return M
