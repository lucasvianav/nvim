local o  = vim.opt
local v  = vim.v
local fn = vim.fn

o.foldmethod = 'indent'

o.fillchars    = [[fold: ]]
o.foldnestmax  = 4 -- fold 4 nested indent levels at most
o.foldminlines = 0 -- enable folding 1+ lines

o.foldtext = [[substitute(getline(v:foldstart),'\S.\+$','','').'+-- ... (' . (v:foldend - v:foldstart + 1) . ' lines folded) --+']]
-- o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').' ... '.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines folded)']]

