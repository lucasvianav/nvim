local map = require('v.util.mappings').map

-- sets <Leader> to <Space>
vim.g.mapleader = ' '

-- substitutes Esc by Ctrl+C in normal mode
map('n', '<C-c>', '<Esc>')

-- leave terminal mode with jk
map('t', 'jk', [[<C-\><C-n>]])

-- use alt + shift + hjkl to resize windows
map('n', '<S-M-J>', '2<C-w>-')
map('n', '<S-M-K>', '2<C-w>+')
map('n', '<S-A-H>', '2<C-w><')
map('n', '<S-A-L>', '2<C-w>>')

-- break line after/before current position
map('n', ']b', 'a<CR><Esc>k$')
map('n', '[b', 'i<CR><Esc>k$')

-- get blank new line
map('n', '<Leader>o', 'o<Esc>^Da')
map('n', '<Leader>O', 'O<Esc>^Da')

-- delete word with alt + backspace
map('i', '<M-BS>', '<C-w>')

-- delete word with ctrl + backspace (it's actually
-- ctrl + shift + alt + backspace, but I've remapped
-- that to ctrl + backspace in Kitty, so yeah)
map('i', '<M-C-S-H>', '<C-w>')
