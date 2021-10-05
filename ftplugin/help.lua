local o = vim.opt_local

o.number = false
o.relativenumber = false
o.list = false
o.colorcolumn = ''
o.concealcursor = 'nc'

-- quit help window with q
map({ 'n', 'v' }, 'q', '<cmd>q<cr>', { buffer = true })
