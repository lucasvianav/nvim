local function set (property, value)
    vim.g['qs_' .. property] = value
end

set('highlight_on_keys',  {'f','F','t','T'})          -- trigger a highlight in the appropriate direction
set('filetype_blacklist', {'startify','dashboard'})   -- don't use plugin in startify/dashboard
set('max_chars',          240)                        -- dont highlight anything beyond 240 chars

vim.cmd([[hi QuickScopePrimary   gui=underline,bold cterm=underline,bold]])
vim.cmd([[hi QuickScopeSecondary gui=underline,bold cterm=underline,bold ]])

