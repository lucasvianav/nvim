-- TODO: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/external.lua
-- TODO: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/external.lua
-- TODO: https://github.com/akinsho/dotfiles/blob/f714d4cdd2de74c7393ca3ae69bdbb3619e06174/.config/nvim/plugin/autocommands.lua#L158-L187
-- TODO: https://github.com/akinsho/dotfiles/blob/main/tmux/.tmux.conf
-- TODO: https://github.com/akinsho/dotfiles/blob/main/tmux/tmux-status.conf
-- TODO: https://www.reddit.com/r/neovim/comments/r0omlv/start_your_search_from_a_more_comfortable_place/

local colors = require('v.utils').colors
local o = vim.opt

local M = {}

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
M.colorscheme = 'tokyonight'

--- function to be ran after a colorscheme is applied
M.post_colorscheme_hook = function()
  require('v.utils.highlights').set_highlights({
    -- { 'CursorLine', { bg = colors.cyan_grey_dark } },
    -- { 'ColorColumn', { bg = colors.cyan_grey_dark } },
    { 'NormalFloat', { link = 'Normal' } },
    { 'FloatBorder', { transparent = true } },
    { 'Folded', { transparent = true } },
    { 'BufferLineFill', { transparent = true } },
    { 'TabLine', { transparent = true, fg = colors.cyan_grey } },
    { 'TabLineFill', { transparent = true } },
    {
      'TabLineSel',
      {
        bg = colors.grey_dark,
        fg = colors.off_white,
      },
    },
  })
end

o.listchars = {
  conceal = '┊',
  eol = ' ', -- ↲
  extends = '>',
  nbsp = '␣',
  precedes = '<',
  space = ' ',
  tab = '» ',
  trail = '•',
}

o.fillchars = {
  eob = ' ',
  fold = ' ',
  stl = ' ',
  stlnc = ' ',
}

return M
