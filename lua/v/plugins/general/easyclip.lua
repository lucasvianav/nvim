local g = vim.g

g.EasyClipUseSubstituteDefaults = true -- doesn't work for some reason
g.EasyClipUseCutDefaults        = false
g.EasyClipAutoFormat            = true

-- use x  for substituting
map('n', 's',  '<plug>SubstituteOverMotionMap', { noremap = false })
map('n', 'ss', '<plug>SubstituteLine', { noremap = false })
map('x', 's',  '<plug>XEasyClipPaste', { noremap = false })
map('n', 'S',  '<plug>SubstituteToEndOfLine', { noremap = false })
map('n', 'gs', '<plug>G_SubstituteOverMotionMap', { noremap = false })
map('n', 'gS', '<plug>G_SubstituteToEndOfLine', { noremap = false })

-- use x for cutting
map('n', 'x',  '<Plug>MoveMotionPlug', { noremap = false })
map('x', 'x',  '<Plug>MoveMotionXPlug', { noremap = false })
map('n', 'xx', '<Plug>MoveMotionLinePlug', { noremap = false })
map('n', 'X',  '<Plug>MoveMotionEndOfLinePlug', { noremap = false })

-- toggle paste autoformat
map('n', '<leader>cf', '<plug>EasyClipToggleFormattedPaste', { noremap = false })

-- paste in insert mode
map('i', '<c-v>', '<plug>EasyClipInsertModePaste', { noremap = false })

-- navigate through the yank ring
map('n', ']p', '<Plug>EasyClipRotateYanksForward', { noremap = false })
map('n', '[p', '<Plug>EasyClipRotateYanksBackward', { noremap = false })
map('x', ']p', '<Plug>EasyClipRotateYanksForward', { noremap = false })
map('x', '[p', '<Plug>EasyClipRotateYanksBackward', { noremap = false })
