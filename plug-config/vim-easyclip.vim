let g:EasyClipUseSubstituteDefaults = 1
let g:EasyClipUseCutDefaults = 0
let g:EasyClipAutoFormat = 1

" Enables x for cut
nmap x <Plug>MoveMotionPlug
xmap x <Plug>MoveMotionXPlug
nmap xx <Plug>MoveMotionLinePlug
nmap X <Plug>MoveMotionEndOfLinePlug

" Toggle paste autoformat
nmap <leader>cf <plug>EasyClipToggleFormattedPaste

" Paste in insert mode
imap <c-v> <plug>EasyClipInsertModePaste

nmap ]p <Plug>EasyClipRotateYanksForward
nmap [p <Plug>EasyClipRotateYanksBackward
