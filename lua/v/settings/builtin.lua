-- disable builtin plugins
require('v.utils').set_viml_options('loaded', {
    'gzip',
    'zip',
    'zipPlugin',
    'tar',
    'tarPlugin',
    'getscript',
    'getscriptPlugin',
    'vimball',
    'vimballPlugin',
    '2html_plugin',
    'matchit',
    'matchparen',
    'logiPat',
    'rrhelper',
    -- 'netrw',
    -- 'netrwPlugin',
    -- 'netrwSettings',
    -- 'netrwFileHandlers',
}, 1)

