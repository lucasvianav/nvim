local opts = { noremap = true, silent = true }

require('bufresize').setup({
    register = {
        keys = {
            { 'n', '<C-w><', '<C-w><', opts },
            { 'n', '<C-w>>', '<C-w>>', opts },
            { 'n', '<C-w>+', '<C-w>+', opts },
            { 'n', '<C-w>-', '<C-w>-', opts },
            { 'n', '<C-w>_', '<C-w>_', opts },
            { 'n', '<C-w>=', '<C-w>=', opts },
            { 'n', '<C-w>|', '<C-w>|', opts },
        },
        trigger_events = {
            'BufWinEnter',
            'WinEnter',
            'VimEnter',
        },
    },
    resize = {
        keys = {},
        trigger_events = { 'VimResized' },
    },
})

local function add_map(mode, lhs, rhs)
    local cmd = [[<cmd>lua require('bufresize').register()<cr>]]
    map(mode, lhs, rhs .. cmd)
end

add_map('n', '<S-M-J>', '2<C-w>-')
add_map('n', '<S-M-K>', '2<C-w>+')
add_map('n', '<S-A-H>', '2<C-w><')
add_map('n', '<S-A-L>', '2<C-w>>')

