local o  = vim.opt
local v  = vim.v
local fn = vim.fn

o.foldmethod = 'indent'

o.fillchars    = [[fold: ]]
o.foldnestmax  = 4 -- fold 4 nested indent levels at most
o.foldminlines = 1 -- enable folding 2+ lines

-- TODO: figure out why cindent doesn't work as expected
-- and convert this to lua
-- https://github.com/lukas-reineke/dotfiles/blob/5b84e9264d3ca9e40fd773642e5a1d335224733e/vim/lua/fold.lua#L14-L25
-- https://github.com/JoosepAlviste/dotfiles/blob/b09a4eed7bf4c7862a02aa8b14ffe29896a0bfa5/config/nvim/lua/j/folding.lua#L4-L10
o.foldtext = [[substitute(getline(v:foldstart),'\S.\+$','','').'+-- '.substitute(getline(v:foldstart),'^\s\+\(.\{1,40}\).*','\1','').' ... (' . (v:foldend - v:foldstart + 1) . ' lines folded) --+']]
-- o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').' ... '.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines folded)']]

