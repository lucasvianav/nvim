-- settings that for some unkown reason are getting overwritten

local o = vim.opt

o.showtabline = 1 -- tabline overwrites it

-- TODO: https://github.com/JoosepAlviste/dotfiles/blob/b09a4eed7bf4c7862a02aa8b14ffe29896a0bfa5/config/nvim/lua/j/settings.lua#L75-L87
o.formatoptions:append({ 'tcjnl' }) -- better formatting options (:help it)

o.formatoptions:remove({ 'o' }) -- no newline continuation of comments
