local function set (property, value)
    vim.g['vimtex_' .. property] = value
end

set('compiler_method',                     'latexmk')
set('compiler_progname',                   'nvr')
set('enabled',                             true)
set('fold_enabled',                        true)
set('fold_manual',                         true)
set('format_enabled',                      true)
set('quickfix_autoclose_after_keystrokes', 3)
set('quickfix_open_on_warning',            false)
set('syntax_conceal_default',              false)
set('view_method',                         'mupdf')
set('complete_bib', {
    'simple' = 1,
    'menu_fmt' = '@year, @author_short, @title',
})

