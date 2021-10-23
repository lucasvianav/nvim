" TODO: let s:formatoptions = v:lua.require('v.settings').general.formatoptions

augroup FormatOptionsManagement
    au!
    au FileType * setlocal formatoptions-=o
augroup END
