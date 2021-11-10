require('indent_blankline').setup({
    buftype_exclude = {
        'terminal',
        'NvimTree',
    },
    filetype_exclude = {
        'help',
        'terminal',
        'dashboard',
        'packer',
        'startify',
        'NvimTree',
        'lsp-installer',
    },

    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    show_end_of_line = false,
    show_current_context = true,
    show_context_start = true,
})
