local colors = require('utils').colors
local cmd = vim.cmd
local o = vim.opt

o.pumblend = 10

-- the background color is dark
o.background = 'dark'

-- only the chosen colorscheme
-- will be loaded by packer :)
colorscheme = 'tokyonight'

-- common config to be run for each plugin
appearanceCommands = [[
    hi Folded ctermbg=NONE guibg=NONE
]]

o.colorcolumn    = '+1'          -- show mark at column 80
o.cursorline     = true          -- highlights current line
o.laststatus     = 2             -- always display the status line
o.number         = true          -- line numbers
o.relativenumber = true          -- relative line numbers
o.pumheight      = 10            -- makes pum menu smaller
o.ruler          = true          -- show cursor position
o.scrolloff      = 1             -- number of screen lines around cursor
o.showtabline    = 2             -- always show tab line (top bar)
o.sidescrolloff  = 5             -- number of screen columns around cursor
o.signcolumn     = 'yes'         -- always display the signcolumn
o.termguicolors  = true          -- true color support
o.wrap           = false         -- don't wrap lines
o.showmode       = false         -- hide --INSERT--, --VISUAL--, etc
o.list           = true          -- show listchars (below)

o.listchars = {
    conceal  = '┊',
    eol      = ' ',
    extends  = '>',
    nbsp     = '☠',
    precedes = '<',
    space    = ' ', -- ␣
    tab      = '» ',
    trail    = '·',
}

