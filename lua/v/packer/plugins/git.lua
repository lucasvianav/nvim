-- TODO: https://github.com/pwntester/octo.nvim

local M = {
  -- git CLI for command mode
  -- TODO: something like this would be nice https://www.reddit.com/r/neovim/comments/qatokl/using_nvim_as_mergetool_with_vimfugitive/
  {
    'tpope/vim-fugitive',
    requires = {
      'tpope/vim-rhubarb',    -- integration with GitHub
      'tommcdo/vim-fubitive', -- integration with BitBucket
    },
    cmd = {
      'Git',
      'GBrowse',
      'Gdiff',
      'Gdiffsplit',
      'Gvdiffsplit',
    },
    keys = {
      '<leader>gd',
      '<leader>gh',
      '<leader>gl',
      '<leader>gg',
      '<Leader>ga',
      { 'v', '<leader>gg' },
    },
    commit = '4a745ea72fa93bb15dd077109afbb3d1809383f2',
  },

  -- git decorations
  {
    'lewis6991/gitsigns.nvim',
    after = 'plenary.nvim',
    event = 'CursorHold',
    commit = '1796c7cedfe7e5dd20096c5d7b8b753d8f8d22ebkA',
  },

  -- practical git diff for modified files
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    after = 'devicons',
    commit = '4516612fe98ff56ae0415a259ff6361a89419b0a',
  },
}

return M
