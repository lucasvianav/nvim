require('better_escape').setup({
    mapping = { 'jk' },
    timeout = 200,
    keys = '<Esc>',

    --[[ TODO: why is this not working??
        https://www.reddit.com/r/neovim/comments/ptrio7/escape_insert_mode_with_no_delay_when_typing/
    ]]--

    -- keys = function()
    --     inspect(vim.fn.complete_info()))
    --     return vim.fn.pumvisible() and '<C-e><Esc>' or '<Esc>'
    -- end,
})

