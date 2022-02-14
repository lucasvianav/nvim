require('gitsigns').setup({
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,

    signs = {
        add = {
            hl = 'GitSignsAdd',
            text = '+',
            numhl = 'GitSignsAddNr',
            linehl = 'GitSignsAddLn',
        },
        change = {
            hl = 'GitSignsChange',
            text = '~',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn',
        },
        delete = {
            hl = 'GitSignsDelete',
            text = '_',
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn',
        },
        topdelete = {
            hl = 'GitSignsDelete',
            text = '‾',
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn',
        },
        changedelete = {
            hl = 'GitSignsChange',
            text = '~',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn',
        },
    },

    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        require('v.utils.mappings').set_keybindings({
            { { 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>' },
            { { 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>' },
            { 'n', '<leader>hu', gs.undo_stage_hunk },
            { 'n', '<leader>hp', gs.preview_hunk },
            { 'n', '<leader>hi', gs.blame_line },
            {
                'n',
                '<leader>hI',
                function()
                    gs.blame_line({ full = true })
                end,
            },
            { 'n', '<leader>hU', gs.reset_buffer_index },
            { 'n', '<leader>hb', gs.toggle_current_line_blame },
            { 'n', ']h', "&diff ? ']h' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true } },
            { 'n', '[h', "&diff ? '[h' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true } },
            { { 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>' },
        }, {
            buffer = bufnr,
        })
    end,

    current_line_blame = false,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
    },
    current_line_blame_formatter_opts = {
        relative_time = false,
    },

    preview_config = {
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
    },
})
