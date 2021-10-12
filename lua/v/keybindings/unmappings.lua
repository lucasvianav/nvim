local unmap = require('v.util.mappings').unmap

-- unbinds escape key
unmap('i', '<Esc>')
unmap('v', '<Esc>')

-- unbinds standalone space
-- key in normal mode
unmap('n', '<Space>')

-- unbinds arrow keys in insert mode
unmap('i', '<Up>')
unmap('i', '<Down>')
unmap('i', '<Right>')
unmap('i', '<Left>')

