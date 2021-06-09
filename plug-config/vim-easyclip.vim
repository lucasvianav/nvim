let g:EasyClipUseSubstituteDefaults = 1
let g:EasyClipUseCutDefaults = 0
let g:EasyClipAutoFormat = 1

" nnoremap s <plug>SubstituteOverMotionMap
" nnoremap ss <plug>SubstituteLine
" xnoremap s <plug>XEasyClipPaste
" nnoremap S <plug>SubstituteToEndOfLine
" nnoremap gs <plug>G_SubstituteOverMotionMap
" nnoremap gS <plug>G_SubstituteToEndOfLine

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
