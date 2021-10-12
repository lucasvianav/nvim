require('better_escape').setup({
    mapping = { 'jk' },
    timeout = 200,
    -- keys_before_delete = function()
    --     local selected = vim.fn.complete_info({ 'selected' }).selected
    --     require('v.utils.wrappers').inspect(vim.fn.complete_info())
    --     return selected ~= -1 and '<C-e>' or ''
    -- end,
    keys = '<Esc>',
})

