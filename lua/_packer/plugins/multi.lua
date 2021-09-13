local eval = vim.api.nvim_eval
local cmd = vim.cmd

local function set (property, value)
    vim.g['VM_' .. property] = value
end

set('quit_after_leaving_insert_mode', true)
set('skip_empty_lines',               true)
set('default_mappings',               false)
set('mouse_mappings',                 true)

set('maps', {
    ['Find Under']         = '',
    ['Find Subword Under'] = '',
    ['Add Cursor Down']    = '',
    ['Add Cursor Up']      = '',
    ['Select All']         = 'gl',
    ['Toggle Mappings']    = '',
    ['Exit']               = '<C-C>',
})

