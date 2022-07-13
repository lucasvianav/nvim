local set_keybindings = require('v.utils.mappings').set_keybindings

set_keybindings({
  -- tab movement with ctrl + tab
  -- and ctrl + shift + tab (you
  -- also need to config your
  -- terminal emulator for it)
  { 'n', '<C-Tab>', '<cmd>tabn<CR>' },
  { 'n', '<C-S-Tab>', '<cmd>tabp<CR>' },

  -- toggle buffer last visited buffer
  { 'n', '<BS>', '<C-^>' },

  -- toggle buffer last visited tab
  { 'n', '<M-C-S-H>', 'g<Tab>' },

  -- better window navigation
  { 'n', '<C-h>', '<C-w>h' },
  { 'n', '<C-j>', '<C-w>j' },
  { 'n', '<C-k>', '<C-w>k' },
  { 'n', '<C-l>', '<C-w>l' },

  -- better nav for omnicomplete
  { { 'c', 'i' }, '<C-j>', '<C-n>' },
  { { 'c', 'i' }, '<C-k>', '<C-p>' },

  -- ignore trailing whitespaces when going to end of line
  { 'n', '$', 'g_' },

  -- open document for current daily
  {
    'n',
    '<leader>d',
    function()
      require('v.utils.dailies').open_curr(vim.v.count)
    end,
  },
})
