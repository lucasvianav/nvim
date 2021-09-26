local o  = vim.opt
local v  = vim.v
local fn = vim.fn

o.foldmethod = 'indent'

o.fillchars    = [[fold: ]]
o.foldnestmax  = 4 -- fold 4 nested indent levels at most
o.foldminlines = 1 -- enable folding 2+ lines

-- TODO: figure out why cindent doesn't work as expected
o.foldtext = [[substitute(getline(v:foldstart),'\S.\+$','','').'+-- '.substitute(getline(v:foldstart),'^\s\+\(.\{1,40}\).*','\1','').' ... (' . (v:foldend - v:foldstart + 1) . ' lines folded) --+']]
-- o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').' ... '.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines folded)']]

