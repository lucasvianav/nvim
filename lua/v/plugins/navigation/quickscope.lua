require('v.utils').set_viml_options('qs', {
    -- dont highlight anything beyond 240 chars
    max_chars = 240,

    -- trigger a highlight in the appropriate direction
    highlight_on_keys = {
        'f', 'F',
        't', 'T',
    },

    -- don't use plugin in startify/dashboard
    filetype_blacklist = {
        'startify',
        'dashboard',
        'NvimTree',
    },
})

