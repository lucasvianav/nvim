local M = {
  -- start screen
  {
    'glepnir/dashboard-nvim',
    cmd = {
      'Dashboard',
      'DashboardNewFile',
    },
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
  },

  -- nerdtree-like file explorer
  {
    'kyazdani42/nvim-tree.lua',
    as = 'nvim-tree',
    after = 'devicons',
    cmd = {
      'NvimTreeToggle',
      'NvimTreeFindFile',
      'NvimTreeClose',
    },
    keys = '<Leader>e',
  },

  -- ranger file explorer
  {
    'kevinhwang91/rnvimr',
    as = 'ranger',
    cmd = 'RnvimrToggle',
    keys = '<Leader>r',
  },

  -- highlight f/F and t/T targets
  {
    'unblevable/quick-scope',
    as = 'quickscope',
    keys = { 'f', 'F', 't', 'T' },
    __opts = { setup = true },
    disable = true,
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
      '<leader>ff',
      '<leader>fd',
      '<leader>fn',
      '<leader>fu',
      '<leader>fpu',
      '<leader>ca',
      '<leader>fp',
      '<leader>fb',
      '<leader>fw',
      'gd',
      'gr',
      'gi',
    },
  },

  -- auto-session picker for telescope
  -- TODO: move this inside telescope table?
  {
    'rmagatti/session-lens',
    after = {
      'telescope.nvim',
      'auto-session',
    },
  },
}

return M
