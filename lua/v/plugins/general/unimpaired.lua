-- <Space><Space> surrounds current line
-- or selection with [count] blank lines
map('n', '<Space><Space>', '<Plug>unimpairedBlankAround', { noremap = false })
map('x', '<Space><Space>', '<Plug>unimpairedBlankAround', { noremap = false })

-- alt + j/k moves current line or
-- selection [count] lines up/down
map('n', '<M-k>', '<Plug>unimpairedMoveUp', { noremap = false })
map('n', '<M-j>', '<Plug>unimpairedMoveDown', { noremap = false })
map('x', '<M-k>', '<Plug>unimpairedMoveKeepSelectionUp', { noremap = false })
map('x', '<M-j>', '<Plug>unimpairedMoveKeepSelectionDown', { noremap = false })

