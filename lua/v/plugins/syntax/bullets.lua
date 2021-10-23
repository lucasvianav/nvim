require('v.utils').set_viml_options('bullets', {
    enable_file_types           = { 'markdown' },
    enable_in_empty_buffers     = false,
    set_mappings                = true,
    mapping_leader              = '',
    delete_last_bullet_if_empty = true,
    line_spacing                = 1,
    pad_right                   = false,
    renumber_on_change          = true,
})

require('v.utils.mappings').map('i', '<S-TAB>', '<C-D>', { noremap = false })

