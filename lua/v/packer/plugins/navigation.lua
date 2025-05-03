local M = {
  -- start screen
  {
    'glepnir/dashboard-nvim',
    cmd = {
      'Dashboard',
      'DashboardNewFile',
    },
    reuqires = 'nvim-tree/nvim-web-devicons',
    commit = 'b0551fae871fc39454a67cca1adcf76fbe2f61f9',
  },

  -- seamless navigation between neovim widows and tmux panes
  {
    'numToStr/Navigator.nvim',
    keys = {
      '<C-h>',
      '<C-j>',
      '<C-k>',
      '<C-l>',
    },
    cond = function()
      return vim.env.TMUX ~= nil
    end,
    commit = '91d86506ac2a039504d5205d32a1d4bc7aa57072',
  },

  -- nerdtree-like file explorer
  {
    'nvim-tree/nvim-tree.lua',
    as = 'nvim-tree',
    after = 'devicons',
    cmd = {
      'NvimTreeToggle',
      'NvimTreeFindFile',
      'NvimTreeClose',
    },
    keys = '<Leader>e',
    commit = '582ae48c9e43d2bcd55dfcc8e2e7a1f29065d924',
  },

  -- ranger file explorer
  {
    'kevinhwang91/rnvimr',
    as = 'ranger',
    cmd = 'RnvimrToggle',
    keys = '<Leader>r',
    commit = '57f7a8edd629791557d1315463d9fb2e411a45f1',
  },

  -- highlight f/F and t/T targets
  {
    'unblevable/quick-scope',
    as = 'quickscope',
    keys = { 'f', 'F', 't', 'T' },
    __opts = { setup = true },
    commit = 'f2b6043e04d9ef05205c8953e389304a4c1946f2',
  },

  -- run commands in tmux pane from neovim
  {
    'preservim/vimux',
    cmd = {
      'VimuxPromptCommand',
      'VimuxRunLastCommand',
      'VimuxInspectRunner',
      'VimuxZoomRunner',
      'VimuxClearScreenHistory',
      'VimuxTogglePane',
    },
    keys = {
      '<Leader>tp',
      '<Leader>tr',
      '<Leader>ti',
      '<Leader>tz',
      '<Leader>tc',
      '<Leader>tt',
    },
    cond = function()
      return vim.env.TMUX ~= nil
    end,
    commit = '7db6b2f79d432ee3820668b1d4625311dbe1d0ad',
  },

  -- fuzzy finder for lots of stuff
  {
    'nvim-telescope/telescope.nvim',
    after = 'plenary.nvim',
    requires = {
      -- markdown header picker
      { 'crispgm/telescope-heading.nvim' },

      -- C sorter
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },

      -- github and octo integration
      -- { 'nvim-telescope/telescope-github.nvim' },
    },
    keys = {
      '<Leader>ff',
      '<Leader>fd',
      '<Leader>fn',
      '<Leader>fu',
      '<Leader>fpu',
      '<Leader>ca',
      '<Leader>fp',
      '<Leader>fb',
      '<Leader>fw',
      '<Leader>fs',
      'gd',
      'gr',
      'gi',
    },
    commit = 'a4ed82509cecc56df1c7138920a1aeaf246c0ac5',
  },
}

return M
