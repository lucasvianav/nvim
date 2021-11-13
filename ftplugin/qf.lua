-- TODO: write function so <CR> goes to the qf item under the cursor

require('v.utils.mappings').set_keybindings({
    { 'n', '<M-k>', ':cp<cr>', { buffer = true } },
    { 'n', '<M-j>', ':cn<cr>', { buffer = true } },
})
