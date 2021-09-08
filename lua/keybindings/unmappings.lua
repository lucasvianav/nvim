local unmap = require('utils').functions.unmap

-- unbinds escape key
unmap('i', '<Esc>')
unmap('v', '<Esc>')

-- unbinds standalone space
-- key in normal mode
unmap('n', '<Space>')

-- unbinds arrow keys in normal mode
unmap('n', '<Up>')
unmap('n', '<Down>')
unmap('n', '<Right>')
unmap('n', '<Left>')

-- unbinds arrow keys in insert mode
unmap('i', '<Up>')
unmap('i', '<Down>')
unmap('i', '<Right>')
unmap('i', '<Left>')

