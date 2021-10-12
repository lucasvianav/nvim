local g   = vim.g
local cmd = vim.cmd

vim.g.VimuxOrientation = "h" -- open tmux panes as vertical splits
vim.g.VimuxCloseOnExit = 1 -- close pane after exiting vim

cmd('command VimuxClearScreenHistory VimuxClearTerminalScreen | VimuxClearRunnerHistory')

map('n', '<Leader>tp', ':<C-U>VimuxPromptCommand<CR>')
map('n', '<Leader>tr', ':<C-U>VimuxRunLastCommand<CR>')
map('n', '<Leader>ti', ':<C-U>VimuxInspectRunner<CR>')
map('n', '<Leader>tz', ':<C-U>VimuxZoomRunner<CR>')
map('n', '<Leader>tc', ':<C-U>VimuxClearScreenHistory<CR>')
map('n', '<Leader>tt', ':<C-U>VimuxTogglePane<CR>')

