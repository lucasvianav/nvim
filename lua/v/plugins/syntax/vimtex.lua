require('v.utils').set_viml_options('vimtex', {
    compiler_method = 'latexmk',
    compiler_progname = 'nvr',
    enabled = true,
    fold_enabled = true,
    fold_manual = true,
    format_enabled = true,
    quickfix_autoclose_after_keystrokes = 3,
    quickfix_open_on_warning = false,
    syntax_conceal_default = false,
    view_method = 'mupdf',
    complete_bib = {
        simple = 1,
        menu_fmt = '@year, @author_short, @title',
    },
})

