" checks if your terminal has 24-bit color support
if (has("termguicolors")) | set termguicolors | endif

" color theme
colorscheme onedark

" override background
hi Normal ctermbg=none guibg=none
hi NonText ctermbg=none guibg=none

hi Comment cterm=italic

if (has("termguicolors")) | hi LineNr ctermbg=none guibg=none | endif
