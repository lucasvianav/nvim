" directories in which sessions won't be saved
let s:blocklist = [ '~/Desktop', '~/Documents', '~/Downloads', '', '~/Pictures', 'session', '/home' ]

" checks if an element is in the blocklist
function! s:IsBlckd(element)
    return index(s:blocklist, a:element) != -1
endfunction

function! s:GenSessionName()
    let branch = gitbranch#name()
    let branch = empty(branch) ? '' : (' — ' . branch)

    " git repo name if there is one, otherwise directory name
    let gitCommand = "git rev-parse --show-toplevel"
    let path = empty(branch) ? getcwd() : substitute(system(gitCommand), '\n\+$', '', '')

    " gets path relative to home (~)
    let currentDir = fnamemodify(path, ':~:t')

    " if the path isn't relative to
    return !empty(currentDir) ? substitute(currentDir . branch, '/', '-', 'g') : ""
endfunction

function! AutoCreateSession()
    let currentPath = fnamemodify(getcwd(), ':~')
    let currentDir = fnamemodify(currentPath, ':t')
    let sessionName = s:GenSessionName()

    " proceeds only if the current directory
    " isn't blocked and the session is named
    if !( s:IsBlckd(currentPath) || s:IsBlckd(currentDir) || empty(sessionName) )
        " closes all terminals
        silent bufdo if split(bufname(), ":")[0] ==# "term" | bd! | endif

        " create session
        silent execute 'SSave! ' . sessionName
        silent mksession! ./Session.vim "winsize,resize,buffers,curdir,help,tabpages,winpos"
    endif
endfunction

" deletes current startify and vanilla session
function! s:DeleteCurrentSession()
    let currentPath = fnamemodify(getcwd(), ':~')
    let currentDir = fnamemodify(currentPath, ':t')
    let sessionName = s:GenSessionName()

    " proceeds only if the current directory
    " isn't blocked and the session is named
    if !( s:IsBlckd(currentPath) || s:IsBlckd(currentDir) || empty(sessionName) )
        silent exec '!rm -f Session.vim'
        silent exec 'SDelete! ' . sessionName
    endif
endfunction

autocmd VimLeavePre * execute AutoCreateSession()

nnoremap <silent> <Plug>DeleteCurrentSession :<C-U>call <SID>DeleteCurrentSession()<CR>
