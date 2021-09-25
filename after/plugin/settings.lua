local o = vim.opt

o.formatoptions:append({'tcjnl'}) -- better formatting options (:help it)
o.formatoptions:remove({'o'})     -- no newline continuation of comments
