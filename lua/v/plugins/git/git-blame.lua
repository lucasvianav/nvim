require('v.utils').set_viml_options('gitblame', {
    enabled          = false,
    message_template = '<summary> • <author>',
})

require('v.utils.mappings').map('n', '<leader>gi', '<cmd>GitBlameToggle<CR>')
