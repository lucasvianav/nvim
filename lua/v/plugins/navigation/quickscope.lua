local function set (property, value)
    vim.g['qs_' .. property] = value
end

set('max_chars',          240) -- dont highlight anything beyond 240 chars
set('highlight_on_keys',  {    -- trigger a highlight in the appropriate direction
    'f', 'F',
    't', 'T',
})
set('filetype_blacklist', {    -- don't use plugin in startify/dashboard
    'startify',
    'dashboard',
    'NvimTree',
})

