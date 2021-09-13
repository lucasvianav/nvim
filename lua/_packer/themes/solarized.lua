local function set (property, value)
    vim.g['solarized_' .. property] = value
end

-- settings
set('italics',    true)
set('visibility', 'normal')
set('diffmode',   'normal')
set('statusline', 'normal')
set('termtrans',  true)

