" TODO: convert to lua
" https://github.com/sindrets/dotfiles/blob/b18533d6f082618233d5178d0e2864987e240a33/.config/nvim/lua/nvim-config/lib.lua#L102-L105

" make macros work better in visual mode
function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

