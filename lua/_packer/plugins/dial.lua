map('n', '<C-a>',  '<Plug>(dial-increment)', { noremap = false })
map('n', '<C-x>',  '<Plug>(dial-decrement)', { noremap = false })
map('v', 'g<C-a>',  '<Plug>(dial-increment)', { noremap = false })
map('v', 'g<C-x>',  '<Plug>(dial-decrement)', { noremap = false })

-- create sequence
map('v', '<C-a>', '<Plug>(dial-increment-additional)', { noremap = false })
map('v', '<C-x>', '<Plug>(dial-decrement-additional)', { noremap = false })

