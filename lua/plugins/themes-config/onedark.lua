local function set (property, value)
    vim.g['onedark_' .. property] = value
end

-- settings
set('style',                  'darker')
set('transparent_background', true)
set('italic_comment',         true)
set('disable_toggle_style',   true)

