local g   = vim.g
local o   = vim.opt
local cmd = vim.cmd

-- enable syntax highlighting, filetype
-- detection and loading of filetype specific
-- plugins and indentation config
cmd('syntax on')
cmd('filetype plugin indent on')

-- globs to be ignored from vim's path
local path_ignore = '*/node_modules/*,*/__pycache__/*,'

-- TODO: https://github.com/JoosepAlviste/dotfiles/blob/b09a4eed7bf4c7862a02aa8b14ffe29896a0bfa5/config/nvim/lua/j/settings.lua#L103
-- TODO: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/settings.lua

-- general settings
o.autoindent   = true          -- auto indent
o.backup       = false         -- don't backup files before overwriting them
o.expandtab    = true          -- converts tabs to spaces
o.fileencoding = 'UTF-8'       -- the encoding written to file
o.hidden       = true          -- enable multiple buffers
o.inccommand   = 'nosplit'     -- preview :s in real time
o.mouse        = 'a'           -- enables mouse
o.nrformats    = 'alpha'       -- allows letter sequences
o.shiftround   = true          -- round indent
o.shiftwidth   = 4             -- 4 spaces for indentation
o.smartindent  = true          -- makes indenting smart
o.smarttab     = true          -- makes tabbing smarter
o.splitbelow   = true          -- horizontal splits below
o.splitright   = true          -- vertical splits to the right
o.synmaxcol    = 240           -- stop syntax highlighting after 500 chars
o.tabstop      = 4             -- 4 spaces for a tab
o.softtabstop  = 0             -- don't worry about it
o.textwidth    = 79            -- break lines after 79 characters (pip8)
o.updatetime   = 300           -- faster completion
o.wildignore   = path_ignore   -- exclude directories from path
o.writebackup  = false         -- don't backup files before overwriting them
o.timeoutlen   = 500           -- wait-time for mapped sequence to complete (which-key)
o.undofile     = true          -- have persistent undo-tree for buffers
o.breakindent  = true          -- keep wrapped lines indented
o.spell        = false         -- no spelling by default
o.spelllang    = 'en_us,pt_br' -- spelling languages
o.spelloptions = 'camel'       -- detect different words in camelCase
o.shell        = '/bin/bash'   -- faster than Zsh (which I use)

o.path:prepend({'**'})               -- enables recursive use of :find
o.clipboard:prepend({'unnamedplus'}) -- system-wide copy-paste

-- LaTeX settings
g.tex_conceal = ''
g.tex_flavor  = 'latex'

