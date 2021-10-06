require('better_escape').setup({
    mapping = { 'jk' },
    timeout = 200,
    -- keys = '<Esc>',

    -- TODO: why is this not working??
    keys = function()
        local selected = vim.fn.complete_info({ 'selected' }).selected
        return selected ~= -1 and '<C-e><Esc>' or '<Esc>'
    end,
})

