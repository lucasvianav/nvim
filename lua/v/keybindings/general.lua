local set_keybindings = require('v.utils.mappings').set_keybindings

-- sets <Leader> to <Space>
vim.g.mapleader = ' '

set_keybindings({
    -- substitutes Esc by Ctrl+C in normal mode
    { 'n', '<C-c>', '<Esc>' },

    -- leave terminal mode with jk
    { 't', 'jk', [[<C-\><C-n>]] },

    -- alt + shift + hjkl to resize windows
    { 'n', '<S-M-J>', '2<C-w>-' },
    { 'n', '<S-M-K>', '2<C-w>+' },
    { 'n', '<S-A-H>', '2<C-w><' },
    { 'n', '<S-A-L>', '2<C-w>>' },

    -- break line after/before current position
    { 'n', ']b', 'a<CR><Esc>k$' },
    { 'n', '[b', 'i<CR><Esc>k$' },

    -- get blank new line
    { 'n', '<Leader>o', 'o<Esc>^Da' },
    { 'n', '<Leader>O', 'O<Esc>^Da' },

    -- delete word with alt + backspace
    { 'i', '<M-BS>', '<C-w>' },

    -- delete word with ctrl + backspace (it's actually
    -- ctrl + shift + alt + backspace, but I've remapped
    -- that to ctrl + backspace in Kitty, so yeah)
    { 'i', '<M-C-S-H>', '<C-w>' },

    -- indenting in visual mode
    -- maintains selection
    { 'v', '<', '<gv' },
    { 'v', '>', '>gv' },

    -- selects last pasted text
    { 'n', 'gp', '`[v`]' },
    { 'n', 'gP', '`[V`]' },

    -- hides highlights
    { 'n', '<Leader>n', '<CMD>noh<CR>' },

    -- untabs in insert mode
    { 'i', '<S-TAB>', '<C-D>' },

    -- save with Enter key
    { 'n', '<CR>', '<CMD>update<CR>' },
})
