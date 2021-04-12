function! s:split(...) abort
    let direction = a:1
    let file = a:2
    call VSCodeCall(direction == 'h' ? 'workbench.action.splitEditorDown' : 'workbench.action.splitEditorRight')
    if file != ''
        call VSCodeExtensionNotify('open-file', expand(file), 'all')
    endif
endfunction

function! s:splitNew(...)
    let file = a:2
    call s:split(a:1, file == '' ? '__vscode_new__' : file)
endfunction

function! s:closeOtherEditors()
    call VSCodeNotify('workbench.action.closeEditorsInOtherGroups')
    call VSCodeNotify('workbench.action.closeOtherEditors')
endfunction

function! s:manageEditorSize(...)
    let count = a:1
    let to = a:2
    for i in range(1, count ? count : 1)
        call VSCodeNotify(to == 'increase' ? 'workbench.action.increaseViewSize' : 'workbench.action.decreaseViewSize')
    endfor
endfunction

function! s:openVSCodeCommandsInVisualMode()
    normal! gv
    let visualmode = visualmode()
    if visualmode == "V"
        let startLine = line("v")
        let endLine = line(".")
        call VSCodeNotifyRange("workbench.action.showCommands", startLine, endLine, 1)
    else
        let startPos = getpos("v")
        let endPos = getpos(".")
        call VSCodeNotifyRangePos("workbench.action.showCommands", startPos[1], endPos[1], startPos[2], endPos[2], 1)
    endif
    call feedkeys('gv=', 'n')
    call feedkeys('gv', 'n')
endfunction

function! s:openWhichKeyInVisualMode()
    normal! gv
    let visualmode = visualmode()
    if visualmode == "V"
        let startLine = line("v")
        let endLine = line(".")
        call VSCodeNotifyRange("whichkey.show", startLine, endLine, 1)
    else
        let startPos = getpos("v")
        let endPos = getpos(".")
        call VSCodeNotifyRangePos("whichkey.show", startPos[1], endPos[1], startPos[2], endPos[2], 1)
    endif
endfunction

" Try and move lines in visual mode
function! s:MoveLine(direction)
    if visualmode() == 'V' && (a:direction == "Up" || a:direction == "Down")
        let startLine = line("v")
        let endLine = line(".")
        normal <C-C>

        call VSCodeNotifyRange("editor.action.moveLines" . a:direction . "Action", startLine, endLine, 0)

        sleep 200m
        call feedkeys('gv=', 'n')
    endif

    call feedkeys('gv', 'n')
    
    return ''
endfunction

command! -complete=file -nargs=? Split call <SID>split('h', <q-args>)
command! -complete=file -nargs=? Vsplit call <SID>split('v', <q-args>)
command! -complete=file -nargs=? New call <SID>split('h', '__vscode_new__')
command! -complete=file -nargs=? Vnew call <SID>split('v', '__vscode_new__')
command! -bang Only if <q-bang> == '!' | call <SID>closeOtherEditors() | else | call VSCodeNotify('workbench.action.joinAllGroups') | endif

nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
" map gf :let mycurf=expand("<cfile>")<cr> :execute("e ".mycurf)<cr> <S-Tab>

nnoremap <silent> <C-w>_ :<C-u>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>
xnoremap <silent> <C-P> :<C-u>call <SID>openVSCodeCommandsInVisualMode()<CR>

nnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>

" makes vscode actions work in visual mode
" xnoremap <silent> <M-k> :call <SID>MoveLine("Up")<CR>
" xnoremap <silent> <M-j> :call <SID>MoveLine("Down")<CR>
" xnoremap <silent> <M-k> :<S-Home><BS> call VSCodeNotifyRange("editor.action.moveLinesUpAction", getpos("'<")[1], getpos("'>")[1], 0)<CR>gv
" xnoremap <silent> <M-j> :<S-Home><BS> call VSCodeNotifyRange("editor.action.moveLinesDownAction", getpos("'<")[1], getpos("'>")[1], 0)<CR>gv
