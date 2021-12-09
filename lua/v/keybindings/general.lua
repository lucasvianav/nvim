local set_keybindings = require('v.utils.mappings').set_keybindings

-- sets <Leader> to <Space>
vim.g.mapleader = ' '

set_keybindings({
    -- substitutes Esc by Ctrl+C in normal mode
    { 'n', '<C-c>', '<Esc>' },

    -- leave terminal mode with jk
    { 't', 'jk', [[<C-\><C-n>]] },

    -- break line after/before current position
    { 'n', ']b', 'a<CR><Esc>k$' },
    { 'n', '[b', 'i<CR><Esc>k$' },

    -- get blank new line
    { 'n', '<Leader>o', 'o<Esc>^Da' },
    { 'n', '<Leader>O', 'O<Esc>^Da' },

    -- new line above or below in insert mode
    { 'i', '<C-CR>', '<C-O>o' },
    { 'i', '<S-CR>', '<C-O>O' },

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

    -- show last 40 messages (by Justinmk)
    { 'n', 'g>', '<cmd>set nomore<bar>40messages<bar>set more<CR>' },

    -- disable all other folds
    { 'n', '<leader>z', 'zMzvzz' },

    -- gf in a vertical split
    { 'n', '<c-w>f', '<c-w>vgf' },

    -- replay macro in q register
    { 'n', 'Q', '@q' },

    -- rerun the last command
    { 'n', '<leader><leader>c', ':<up><cr>' },

    -- execute currenbt line/selection
    { { 'n', 'v' }, '<leader>x', '<cmd>lua require("v.utils").exec_line()<CR>' },

    -- FIXME: how to not get delay?
    -- insert escaped '/' while inputting a search pattern (by akisho)
    -- { 'c', '/', [[getcmdtype() == "/" ? "\\/" : "/"]], { expr = true } },
})
