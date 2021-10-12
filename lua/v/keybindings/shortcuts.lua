local map = require('v.util.mappings').map

-- indenting in visual mode
-- maintains selection
map('v', '<', '<gv')
map('v', '>', '>gv')

-- selects last pasted text
map('n', 'gp', '`[v`]')
map('n', 'gP', '`[V`]')

-- hides highlights
map('n', '<Leader>n', ':noh<CR>')

-- untabs in insert mode
map('i', '<S-TAB>', '<C-D>')

