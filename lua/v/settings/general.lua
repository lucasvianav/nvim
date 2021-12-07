local o = vim.opt

local M = {}

-- enable syntax highlighting, filetype
-- detection and loading of filetype specific
-- plugins and indentation config
vim.api.nvim_command('syntax on')
vim.api.nvim_command('filetype plugin indent on')

-- general settings
o.autoindent = true -- auto indent
o.backup = false -- don't backup files before overwriting them
o.breakindent = true -- keep wrapped lines indented
o.breakindentopt = 'sbr' -- display showbreak before the indent
o.cursorlineopt = 'both' -- highlight cursorline and cursornumber
o.emoji = false -- handle emoji better (https://www.youtube.com/watch?v=F91VWOelFNE)
o.expandtab = true -- converts tabs to spaces
o.fileencoding = 'UTF-8' -- the encoding written to file
o.foldmethod = 'indent' -- faster
o.foldminlines = 1 -- enable folding 2+ lines
o.foldnestmax = 4 -- fold 4 nested indent levels at most
o.hidden = true -- switch unsaved buffers
o.ignorecase = true -- case insensitive search
o.inccommand = 'nosplit' -- preview :s in real time
o.lazyredraw = true -- redraw screen only when needed
o.linebreak = true -- wrap lines smartly
o.mouse = 'a' -- enables mouse
o.nrformats = 'alpha' -- allows letter sequences
o.shell = '/bin/bash' -- faster than Zsh (which I use)
o.shiftround = true -- round indent
o.shiftwidth = 4 -- 4 spaces for indentation
o.showbreak = '↳' -- indicate wrapped lines
o.smartcase = true -- case sensitive search if there's capital letters
o.smartindent = true -- makes indenting smart
o.smarttab = true -- makes tabbing smarter
o.softtabstop = 0 -- don't worry about it
o.spell = false -- no spelling by default
o.spelloptions = 'camel' -- detect different words in camelCase
o.splitbelow = true -- horizontal splits below
o.splitright = true -- vertical splits to the right
o.synmaxcol = 240 -- stop syntax highlighting after 500 chars
o.tabstop = 2 -- 4 spaces for a tab
o.textwidth = 79 -- break lines after 79 characters (pip8)
o.timeoutlen = 500 -- wait-time for mapped sequence to complete (which-key)
o.undofile = true -- have persistent undo-tree for buffers
o.updatetime = 300 -- faster completion
o.wrapscan = false -- search don't wrap around the EOF
o.writebackup = false -- don't backup files before overwriting them
o.wildmenu = true -- better completion for cli
o.swapfile = false -- backup-like files

o.foldtext = "v:lua.require('v.utils.folding').foldtext()"

-- spelling languages
o.spelllang = {
    'en_us',
    'pt_br',
}

-- globs to be ignored from path
o.wildignore = {
    '**/node_modules/**',
    '**/__pycache__/**,',
    '**/.git/**,',
    '**/.vscode/**,',
    '**/.idea/**,',
    '*.o',
    '*.obj',
    '*.dll',
    '*.jar',
    '*.pyc',
    '*.gif',
    '*.ico',
    '*.jpg',
    '*.jpeg',
    '*.png',
    '*.pdf',
    '*.avi',
    '*.wav',
    '*.*~',
    '*~ ',
    '*.swp',
    '.lock',
    '.DS_Store',
    'tags.lock',
    'tags',
}

-- extensions not required for
-- opening files with gf
o.suffixesadd = {
    '.js',
    '.ts',
    '.jsx',
    '.tsx',
    '.lua',
    '.py',
}

-- system-wide copy-paste
o.clipboard = {
    'unnamed',
    'unnamedplus',
}

-- enables recursive use of :find
o.path:append({
    '*',
    '**',
})

-- what to save in a session
o.sessionoptions = {
    'curdir', -- cwd
    -- 'blank',    -- empty windows
    'help', -- help window
    'winsize', -- window sizes
    -- 'buffers',  -- hidden buffers
    'tabpages', -- tabpages (welp)
    'winpos', -- Neovim window's position
    'folds', -- folding state
}

-- messages
o.shortmess = {
    A = false, -- alert for swap files
    F = true, -- no file info when editing it (breaks autocmd messages)
    O = true, -- file-read message overwrites previous
    S = false, -- show search countt (e.g. [1/5])
    T = true, -- truncate messages in middle
    W = true, -- no "written" or "[w]" when writing
    a = true, -- use abbreviations
    c = true, -- no ins-completion-menu messages
    o = true, -- file-read message overwrites previous
    q = false, -- use "recording @a" instead of "recording"
    s = true, -- :help it
    t = true, -- truncate file messages at the start
}

-- formatting
-- TODO: https://github.com/JoosepAlviste/dotfiles/blob/b09a4eed7bf4c7862a02aa8b14ffe29896a0bfa5/config/nvim/lua/j/settings.lua#L75-L87
o.formatoptions = {
    ['1'] = true, -- break lines *before* 1-letter words (not afer)
    ['2'] = true, -- use indent from 2nd line of a paragraph
    a = false, -- autoformat is bad
    c = true, -- auto-wrap comments
    j = true, -- remove a comment leader when joining lines.
    l = true, -- don't break lines that were already long before insertion
    n = true, -- recognize numbered lists
    o = false, -- don't continue comments in normal mode
    p = true, -- don't break lines at single spaces after periods
    q = true, -- format comments with `gq`
    r = true, -- continue comments in insert mode
    t = false, -- autowrap lines
    v = true, -- break lines only on chars added in this insertion
    w = false, -- fuck trailing whitespaces
}
M.formatoptions = o.formatoptions._value

-- settings for diffs
o.diffopt = {
    'closeoff', -- cancel diff if only one window is remaining
    'context:6', -- context of 6 lines to changes
    'filler', -- show filler lines to keep text synchronized
    'hiddenoff', -- cancel diff for hidden buffers
    'indent-heuristic',
    'internal',
    'iwhite', -- ignore trailing whitespaces
    'vertical', -- use vertical split by default
}

-- surrunding pairs, jumpable with %
o.matchpairs = { '(:)', '{:}', '[:]', '<:>' }

return M
