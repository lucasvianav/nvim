local function set (property, value)
    vim.g['bullets_' .. property] = value
end

set('enable_file_types',           { 'markdown' })
set('enable_in_empty_buffers',     false)
set('set_mappings',                true)
set('mapping_leader',              '')
set('delete_last_bullet_if_empty', true)
set('line_spacing',                1)
set('pad_right',                   false)
set('renumber_on_change',          true)

map('i', '<S-TAB>', '<C-D>', { noremap = false })

