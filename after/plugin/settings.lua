-- settings that for some unkown reason are getting overwritten

local o = vim.opt

o.showtabline = 1 -- tabline overwrites it

o.formatoptions:append({ 'tcjnl' }) -- better formatting options (:help it)

o.formatoptions:remove({ 'o' }) -- no newline continuation of comments
