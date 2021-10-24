require('v.utils').set_viml_options('gutentags', {
    cache_dir = vim.fn.expand('$HOME') .. '/.cache/tags', -- don't pollute my project
    plus_nomap = true, -- don't pollute my mappings
})
