require('indent_blankline').setup({
    char = '▏',

    buftype_exclude  = { 'terminal' },
    filetype_exclude = {
        'help',
        'terminal',
        'dashboard',
        'packer',
        'startify',
    },

    show_trailing_blankline_indent = false,
    show_first_indent_level        = false,
    show_end_of_line               = false,
    show_current_context           = true,
})
