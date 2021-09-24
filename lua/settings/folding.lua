local o  = vim.opt
local v  = vim.v
local fn = vim.fn

o.foldmethod = 'indent'

o.fillchars    = [[fold: ]]
o.foldnestmax  = 4 -- fold 4 nested indent levels at most
o.foldminlines = 1 -- enable folding 2+ lines

-- TODO: get indent level more reliably
-- https://github.com/sindrets/dotfiles/blob/b18533d6f082618233d5178d0e2864987e240a33/.config/nvim/lua/nvim-config/lib.lua#L207-L213
-- TODO: dispaly first folded line
o.foldtext = [[substitute(getline(v:foldstart),'\S.\+$','','').'+-- ... (' . (v:foldend - v:foldstart + 1) . ' lines folded) --+']]
-- o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').' ... '.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines folded)']]

