local o = vim.opt_local

o.colorcolumn = ''
o.synmaxcol = 3000
o.textwidth = 0
o.wrap = true
o.spell = true

require('v.utils.mappings').set_keybindings({
    { 'i', '<C-i>', '<C-c>xsiw*lf*a' },
    { 'i', '<C-b>', '<C-c>xsiw*l.l2f*a' },
    { 'i', '<C-S-i>', '<C-c>xsiW*lf*a' },
    { 'i', '<C-S-b>', '<C-c>xsiW*l.l2f*a' },
    { 'v', '<C-i>', 'S*' },
    { 'v', '<C-b>', 'S*gvS*' },
}, {
    buffer = true,
    noremap = false,
})
