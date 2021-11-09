augroup RelativeNumberManagement
    au!
    au InsertEnter * set norelativenumber
    au CmdlineEnter * set norelativenumber | redraw
    au InsertLeave,CmdlineLeave * set relativenumber
augroup END
