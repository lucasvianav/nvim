-- buffer movement with horizontal arrows
map('n', '<Right>', '<cmd>bn<CR>')
map('n', '<Left>',  '<cmd>bp<CR>')

-- tab movement with vertical arrows
map('n', '<Up>',   '<cmd>tabn<CR>')
map('n', '<Down>', '<cmd>tabp<CR>')

-- toggle buffer last visited buffer
map('n', '<BS>', '<C-^>')

-- better window navigation
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- better nav for omnicomplete
map('i', '<C-j>', '<C-n>')
map('i', '<C-k>', '<C-p>')

-- nnoremap '' ``

