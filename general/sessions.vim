function! GetUniqueSessionName()
    let path = fnamemodify(getcwd(), ':~:t')
    let path = empty(path) ? 'no-project' : path
    let branch = gitbranch#name()
    let branch = empty(branch) ? '' : (' — ' . branch)
    return substitute(path . branch, '/', '-', 'g')
endfunction

function! OnExit()
    silent mksession!
    silent execute 'SSave! ' . GetUniqueSessionName()
endfunction

autocmd VimLeavePre * silent OnExit()
