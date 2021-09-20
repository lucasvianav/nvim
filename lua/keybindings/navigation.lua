-- buffer movement with \<Tab> and <S-Tab>
map('n', '',   '<cmd>bnext<CR>')
map('n', '<S-TAB>', '<cmd>bprevious<CR>')

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

