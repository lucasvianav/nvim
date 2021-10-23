local set_keybindings = require('v.utils.mappings').set_keybindings

set_keybindings({
    -- buffer movement with horizontal arrows
    { 'n', '<Right>', '<cmd>bn<CR>' },
    { 'n', '<Left>', '<cmd>bp<CR>' },

    -- tab movement with vertical arrows
    { 'n', '<Up>', '<cmd>tabn<CR>' },
    { 'n', '<Down>', '<cmd>tabp<CR>' },

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
    { 'i', '<C-j>', '<C-n>' },
    { 'i', '<C-k>', '<C-p>' },
})
