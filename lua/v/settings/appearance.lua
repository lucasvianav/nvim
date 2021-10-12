local colors = require('utils').colors
local o = vim.opt

--[[
TODO: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/highlights.lua
]]
--

o.background = 'dark' -- the background color is dark
o.colorcolumn = '+1' -- show mark at column 80
o.cursorline = true -- highlights current line
o.laststatus = 2 -- always display the status line
o.list = true -- show listchars (below)
o.number = true -- line numbers
o.pumblend = 10 -- pum transparency
o.pumheight = 10 -- makes pum menu smaller
o.relativenumber = true -- relative line numbers
o.ruler = true -- show cursor position
o.scrolloff = 1 -- number of screen lines around cursor
o.showmode = false -- hide --INSERT--, --VISUAL--, etc
o.showtabline = 1 -- always show tab line (top bar)
o.sidescrolloff = 5 -- number of screen columns around cursor
o.signcolumn = 'yes:2' -- always display 2 signcolumns
o.termguicolors = true -- true color support
o.wrap = false -- don't wrap lines by default

-- only the chosen colorscheme
-- will be loaded by packer :)
colorscheme = 'tokyonight'

-- common config to be run for each plugin
appearanceCommands = [[
    hi! Folded ctermbg=NONE guibg=NONE
    hi! BufferLineFill ctermbg=none guibg=none
    hi! NormalFloat ctermbg=NONE guibg=NONE
    hi! TabLineFill ctermbg=NONE guibg=NONE
    hi! CursorLine guibg=]] .. colors.grey .. '\n' .. [[
    hi! ColorColumn guibg=]] .. colors.black .. '\n' .. [[
    hi! TabLine    guibg=NONE guifg=]] .. colors.cyan_grey .. '\n' .. [[
    hi! TabLineSel guibg=]] .. colors.grey_dark .. [[ guifg=]] .. colors.off_white .. '\n' .. [[
]]

o.listchars = {
    conceal  = '┊',
    eol      = ' ',
    extends  = '>',
    nbsp     = '☠',
    precedes = '<',
    space    = ' ', -- ␣
    tab      = '» ',
    trail    = '•',
    fold     = ' ',
}
