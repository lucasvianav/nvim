local cmd = vim.api.nvim_command

require('v.utils').set_viml_options('Vimux', {
    Orientation = 'h', -- open tmux panes as vertical splits
    CloseOnExit = false, -- close pane after exiting vim
})

-- TODO: ??
cmd('command VimuxClearScreenHistory VimuxClearTerminalScreen | VimuxClearRunnerHistory')

require('v.utils.mappings').set_keybindings({
    { 'n', '<Leader>tp', ':<C-U>VimuxPromptCommand<CR>' },
    { 'n', '<Leader>tr', ':<C-U>VimuxRunLastCommand<CR>' },
    { 'n', '<Leader>ti', ':<C-U>VimuxInspectRunner<CR>' },
    { 'n', '<Leader>tz', ':<C-U>VimuxZoomRunner<CR>' },
    { 'n', '<Leader>tc', ':<C-U>VimuxClearScreenHistory<CR>' },
    { 'n', '<Leader>tt', ':<C-U>VimuxTogglePane<CR>' },
})
