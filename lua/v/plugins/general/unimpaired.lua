require('v.utils.mappings').set_keybindings({
    -- <Space><Space> surrounds current line
    -- or selection with [count] blank lines
    { 'n', '<Space><Space>', '<Plug>unimpairedBlankAround' },
    { 'x', '<Space><Space>', '<Plug>unimpairedBlankAround' },

    -- alt + j/k moves current line or
    -- selection [count] lines up/down
    { 'n', '<M-k>', '<Plug>unimpairedMoveUp' },
    { 'n', '<M-j>', '<Plug>unimpairedMoveDown' },
    { 'x', '<M-k>', '<Plug>unimpairedMoveKeepSelectionUp' },
    { 'x', '<M-j>', '<Plug>unimpairedMoveKeepSelectionDown' },
})
