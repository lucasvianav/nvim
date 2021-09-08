local map = require('utils').functions.map

-- sets <Leader> to <Space>
vim.g.mapleader = ' '

-- substitutes Esc by Ctrl+C in normal mode
map('n', '<C-c>', '<Esc>')

-- use alt + shift + hjkl to resize windows
map('n', '<S-M-J>', ':<C-U>resize -2<CR>')
map('n', '<S-M-K>', ':<C-U>resize +2<CR>')
map('n', '<S-A-H>', ':<C-U>vertical resize -2<CR>')
map('n', '<S-A-L>', ':<C-U>vertical resize +2<CR>')

-- break line after/before current position
map('n', ']b', 'a<CR><Esc>k$')
map('n', '[b', 'i<CR><Esc>k$')

-- get blank new line
map('n', '<Leader>o', 'o<Esc>^Da')
map('n', '<Leader>O', 'O<Esc>^Da')

