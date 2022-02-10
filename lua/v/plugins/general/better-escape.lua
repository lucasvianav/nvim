require('better_escape').setup({
    mapping = { 'jk' },
    timeout = 200,
    keys = function()
        -- move to the right to keep cursor position
        return vim.fn.col('.') == 1 and '<esc>' or '<esc>l'
    end,
})
