function! GetSessionName()
    let branch = gitbranch#name()
    let branch = empty(branch) ? '' : (' — ' . branch)

    " git repo name if there is one, otherwise directory name
    let path = branch ==# "" ? getcwd() : execute("Git rev-parse --show-toplevel")

    let currentDir = fnamemodify(path, ':~:t')
    let currentDir = empty(currentDir) ? 'no-project' : currentDir

    return substitute(currentDir . branch, '/', '-', 'g')
endfunction

function! OnExit()
    " directories in which sessions won't be saved
    let blocklist = [ 'Desktop', 'Documents', 'Downloads', '', 'Pictures', 'session' ]

    " if the current directory is blocked, end function
    let currentDir = fnamemodify(getcwd(), ':~:t')
    if( index(blocklist, currentDir) != -1 ) | return | endif

    " closes all terminals
    silent bufdo if split(bufname(), ":")[0] ==# "term" | bd! | endif

    " create session
    silent mksession! "winsize,resize,buffers,curdir,help,tabpages"
    silent execute 'SSave! ' . GetSessionName()
endfunction

" deletes current startify and vanilla session
function! s:DeleteCurrentSession()
    silent exec '!rm -f Session.vim'
    silent exec 'SDelete! ' . GetSessionName()
endfunction

autocmd VimLeavePre * execute OnExit()

nnoremap <silent> <Plug>DeleteCurrentSession :<C-U>call <SID>DeleteCurrentSession()<CR>
