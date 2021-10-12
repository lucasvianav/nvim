local g = vim.g

g.surround_no_mappings = true
g.surround_no_insert_mappings = true

map('n', 'ds',  '<Plug>Dsurround', { noremap = false })
map('n', 'cs',  '<Plug>Csurround', { noremap = false })
map('n', 'cS',  '<Plug>CSurround', { noremap = false })
map('n', 'xs',  '<Plug>Ysurround', { noremap = false })
map('n', 'xS',  '<Plug>YSurround', { noremap = false })
map('n', 'xss', '<Plug>Yssurround', { noremap = false })
map('n', 'xSs', '<Plug>YSsurround', { noremap = false })
map('n', 'xSS', '<Plug>YSsurround', { noremap = false })
map('x', 'S',   '<Plug>VSurround', { noremap = false })
map('x', 'gS',  '<Plug>VgSurround', { noremap = false })

