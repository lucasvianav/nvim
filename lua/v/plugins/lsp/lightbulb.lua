-- update lightbulb whenever cursor stops
vim.cmd([[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()]])
