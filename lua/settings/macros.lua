-- make macros work better in visual mode
vim.cmd([[
    function! ExecuteMacroOverVisualRange()
        echo "@".getcmdline()
        execute ":'<,'>normal @".nr2char(getchar())
    endfunction

    xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
]])

