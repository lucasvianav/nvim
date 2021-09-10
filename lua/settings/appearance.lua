local colors = require('utils').colors
local cmd = vim.cmd

-- the background color is dark
vim.o.background = 'dark'

-- only the chosen colorscheme 
-- will be loaded by packer :)
colorscheme = 'tokyonight'

-- common config to be run for each plugin
appearanceCommands = [[
    hi Folded ctermbg=NONE guibg=NONE
]]

-- -- disabling background color
-- cmd([[
--     hi Normal      ctermbg=NONE guibg=NONE
--     hi SignColumn  ctermbg=NONE guibg=NONE
--     hi LineNr      ctermbg=NONE guibg=NONE
--     hi EndOfBuffer ctermbg=NONE guibg=NONE ctermfg=NONE guifg=NONE
--     hi NonText     ctermbg=NONE guibg=NONE
-- ]])

