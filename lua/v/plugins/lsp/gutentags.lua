local function set(property, value)
    vim.g['gutentags_' .. property] = value
end

set('cache_dir', vim.fn.expand('$HOME/.cache/tags')) -- don't pollute my project
set('plus_nomap', true) -- don't pollute my mappings
