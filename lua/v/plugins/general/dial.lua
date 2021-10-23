require('v.utils.mappings').set_keybindings({
    { 'n', '<C-a>',  '<Plug>(dial-increment)', { noremap = false } },
    { 'n', '<C-x>',  '<Plug>(dial-decrement)', { noremap = false } },
    { 'v', 'g<C-a>', '<Plug>(dial-increment)', { noremap = false } },
    { 'v', 'g<C-x>', '<Plug>(dial-decrement)', { noremap = false } },

    -- create sequence
    { 'v', '<C-a>', '<Plug>(dial-increment-additional)', { noremap = false } },
    { 'v', '<C-x>', '<Plug>(dial-decrement-additional)', { noremap = false } },
})
