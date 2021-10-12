local map = require('v.util.mappings').map

-- buffer movement with horizontal arrows
map('n', '<Right>', '<cmd>bn<CR>')
map('n', '<Left>', '<cmd>bp<CR>')

-- tab movement with vertical arrows
map('n', '<Up>', '<cmd>tabn<CR>')
map('n', '<Down>', '<cmd>tabp<CR>')

-- tab movement with ctrl + tab
-- and ctrl + shift + tab (you
-- also need to config your
-- terminal emulator for it)
map('n', '<C-Tab>', '<cmd>tabn<CR>')
map('n', '<C-S-Tab>', '<cmd>tabp<CR>')

-- toggle buffer last visited buffer
map('n', '<BS>', '<C-^>')

-- toggle buffer last visited tab
map('n', '<M-C-S-H>', 'g<Tab>')

-- better window navigation
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- better nav for omnicomplete
map('i', '<C-j>', '<C-n>')
map('i', '<C-k>', '<C-p>')
