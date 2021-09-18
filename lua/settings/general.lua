local g = vim.g
local o = vim.opt
local cmd = vim.cmd

-- enable syntax highlighting, filetype
-- detection and loading of filetype specific
-- plugins and indentation config
cmd('syntax on')
cmd('filetype plugin indent on')

-- globs to be ignored from vim's path
local path_ignore = '*/node_modules/*,*/autoload/*'

-- general settings
o.autoindent     = true            -- auto indent
o.backup         = false           -- don't backup files before overwriting them
o.colorcolumn    = '+1'            -- show mark at column 80
o.cursorline     = true            -- highlights current line
o.expandtab      = true            -- converts tabs to spaces
o.fileencoding   = 'UTF-8'         -- the encoding written to file
o.hidden         = true            -- enable multiple buffers
o.inccommand     = 'nosplit'       -- preview :s in real time
o.laststatus     = 2               -- always display the status line
o.mouse          = 'a'             -- enables mouse
o.nrformats      = 'alpha'         -- allows letter sequences
o.number         = true            -- line numbers
o.pumheight      = 10              -- makes popup menu smaller
o.relativenumber = true            -- relative line numbers
o.ruler          = true            -- show cursor position
o.scrolloff      = 1               -- number of screen lines around cursor
o.shiftround     = true            -- round indent
o.shiftwidth     = 4               -- 4 spaces for indentation
o.showtabline    = 2               -- always show tab line (top bar)
o.sidescrolloff  = 5               -- number of screen columns around cursor
o.signcolumn     = 'yes'           -- always display the signcolumn
o.smartindent    = true            -- makes indenting smart
o.smarttab       = true            -- makes tabbing smarter
o.splitbelow     = true            -- horizontal splits below
o.splitright     = true            -- vertical splits to the right
o.synmaxcol      = 240             -- stop syntax highlighting after 500 chars
o.tabstop        = 4               -- 4 spaces for a tab
o.termguicolors  = true            -- true color support
o.textwidth      = 79              -- break lines after 79 characters (pip8)
o.updatetime     = 300             -- faster completion
o.wildignore     = path_ignore     -- exclude directories from path
o.wrap           = false           -- don't wrap lines
o.writebackup    = false           -- don't backup files before overwriting them
o.showmode       = false           -- hide --INSERT--, --VISUAL--, etc

o.path:append({'**'})                   -- enables recursive use of :find
o.clipboard:append({'unnamedplus'})     -- system-wide copy-paste
o.formatoptions:append({'tcjnl'})       -- better formatting options (:help it)
o.formatoptions:remove({'ro'})          -- no newline continuation of comments

-- LaTeX settings
g.tex_conceal = ''
g.tex_flavor  = 'latex'

