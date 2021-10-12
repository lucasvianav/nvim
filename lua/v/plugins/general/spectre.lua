require('spectre').setup({
    color_devicons = true,
    open_cmd = 'vnew',
    live_update = false, -- auto excute search again when you write any file in vim
    default = {
        find = {
            cmd = "rg",
            options = {},
        },
        replace={ cmd = "sed" }
    },
})

map('n', '<Leader>S', [[:<C-u>lua require('spectre').open()<CR>]])
map('v', '<Leader>S', [[:lua require('spectre').open_visual()<CR>]])

vim.cmd([[command! Spectre lua require('spectre').open()]])

