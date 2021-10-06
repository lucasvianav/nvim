local function set (property, value)
    vim.g['tokyonight_' .. property] = value
end

-- settings
set('style',               'storm')
set('italic_coments',      true)
set('italic_keywords',     false)
set('italic_variables',    false)
set('italic_functions',    false)
set('transparent',         true)
set('transparent_sidebar', true)
set('dark_sidebar',        false)
set('dark_float',          true) -- darker bg for floating windows

