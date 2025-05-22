local o = vim.opt_local

o.textwidth = 0
o.synmaxcol = 3000
o.wrap = true

-- TODO: I'm not sure why vim.opt = ...
-- doesn't work. maybe open an issue?
-- swap it for vim.wo (it's a window option)
vim.api.nvim_command("setlocal spell")
