local o = vim.opt_local

o.colorcolumn = ''
o.textwidth = 0
o.wrap = true

-- TODO: I'm not sure why vim.o.spell = true
-- doesn't work. maybe open an issue?
vim.api.nvim_command('setlocal spell')
