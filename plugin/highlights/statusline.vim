let s:colors = luaeval("require('v.utils').colors.black")
hi! StatusLine guibg=NONE
hi! StatusLineNC gui=underline guifg=s:color guibg=NONE

