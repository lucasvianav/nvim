local o = vim.opt_local

o.textwidth = 0
o.synmaxcol = 3000
o.wrap = true

-- TODO: I'm not sure why vim.opt = ...
-- doesn't work. maybe open an issue?
-- swap it for vim.wo (it's a window option)
vim.api.nvim_command('setlocal spell')

require('v.utils.mappings').set_keybindings({
  { 'i', '<C-i>', '<C-c>xsiw*lf*a' },
  { 'i', '<C-h>', '<C-c>xsiw`lf`a' },
  { 'i', '<C-b>', '<C-c>xsiw*l.l2f*a' },
  { 'i', '<M-i>', '<C-c>xsiW*lf*a' },
  { 'i', '<M-h>', '<C-c>xsiW`lf`a' },
  { 'i', '<M-b>', '<C-c>xsiW*l.l2f*a' },
  { 'v', '<C-i>', 'S*' },
  { 'v', '<C-b>', 'S*gvS*' },
}, {
  buffer = true,
  remap = true,
})
