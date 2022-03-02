require('indent_blankline').setup({
    buftype_exclude = {
        'nofile',
        'prompt',
        'terminal',
    },

    filetype_exclude = {
        'NvimTree',
        'NvimTree_*',
        'dashboard',
        'gitcommit',
        'help',
        'lsp-installer',
        'markdown',
        'packer',
        'packer',
        'sql',
        'startify',
        'terminal',
    },

    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    show_end_of_line = false,
    use_treesitter = true,
    show_foldtext = false,

    show_current_context = true,
    show_current_context_start = true,
    context_patterns = {
        'class',
        'function',
        'method',
        'block',
        'list_literal',
        'selector',
        '^if',
        '^table',
        'if_statement',
        'while',
        'for',
    },
})
