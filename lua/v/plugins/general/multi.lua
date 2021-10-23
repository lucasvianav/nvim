require('v.utils').set_viml_options('VM', {
    quit_after_leaving_insert_mode = true,
    skip_empty_lines               = true,
    default_mappings               = false,
    mouse_mappings                 = true,

    maps = {
        ['Find Under']         = '',
        ['Find Subword Under'] = '',
        ['Add Cursor Down']    = '',
        ['Add Cursor Up']      = '',
        ['Select All']         = 'gl',
        ['Toggle Mappings']    = '',
        ['Exit']               = '<C-C>',
    },
})
