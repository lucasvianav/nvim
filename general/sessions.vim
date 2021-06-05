function! GetUniqueSessionName()
    let path = fnamemodify(getcwd(), ':~:t')
    let path = empty(path) ? 'no-project' : path
    let branch = gitbranch#name()
    let branch = empty(branch) ? '' : (' — ' . branch)
    return substitute(path . branch, '/', '-', 'g')
endfunction

function! OnExit()
    " closes all terminals on exit
    silent bufdo if split(bufname(), ":")[0] == "term" | bd! | endif

    " create session
    silent mksession!
    silent execute 'SSave! ' . GetUniqueSessionName()
endfunction

autocmd VimLeavePre * execute OnExit()
