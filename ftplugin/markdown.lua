local o = vim.opt_local

o.colorcolumn = ''
o.synmaxcol = 3000
o.textwidth = 0
o.wrap = true
o.spell = true

local opts = { buffer = true, noremap = false }
require('v.utils.mappings').set_keybindings({
    { 'i', '<C-i>', '<C-c>xsiw*lf*a', opts },
    { 'i', '<C-b>', '<C-c>xsiw*l.l2f*a', opts },
    { 'i', '<C-S-i>', '<C-c>xsiW*lf*a', opts },
    { 'i', '<C-S-b>', '<C-c>xsiW*l.l2f*a', opts },
    { 'v', '<C-i>', 'S*', opts },
    { 'v', '<C-b>', 'S*gvS*', opts },
})
