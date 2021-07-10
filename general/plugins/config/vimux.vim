" open tmux panes as vertical splits
let g:VimuxOrientation = "h"

" close pane after exiting vim
let g:VimuxCloseOnExit = 1

command VimuxClearScreenHistory VimuxClearTerminalScreen | VimuxClearRunnerHistory

nnoremap silent <Leader>tp :<C-u>VimuxPromptCommand<CR>
nnoremap silent <Leader>tr :<C-u>VimuxRunLastCommand<CR>
nnoremap silent <Leader>ti :<C-u>VimuxInspectRunner<CR>
nnoremap silent <Leader>tz :<C-u>VimuxZoomRunner<CR>
nnoremap silent <Leader>tc :<C-u>VimuxClearScreenHistory<CR>
nnoremap silent <Leader>tt :<C-u>VimuxTogglePane<CR>

