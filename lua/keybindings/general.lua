-- sets <Leader> to <Space>
vim.g.mapleader = ' '

-- substitutes Esc by Ctrl+C in normal mode
map('n', '<C-c>', '<Esc>')

-- leave insert mode with jk (also in terminal)
-- map('i', 'jk', '<Esc>')         -- disabled because of better-insert.vim
-- map('t', 'jk', [[<C-\><C-n>]])  -- disabled because of ranger

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

