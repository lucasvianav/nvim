require('Navigator').setup({ disable_on_zoom = true })

-- Ctrl + hjkl to navigate between vim windows and tmux planes
require('v.utils.mappings').set_keybindings({
    { 'n', '<C-h>', [[:<C-U>lua require('Navigator').left()<CR>]]  },
    { 'n', '<C-j>', [[:<C-U>lua require('Navigator').down()<CR>]]  },
    { 'n', '<C-k>', [[:<C-U>lua require('Navigator').up()<CR>]]    },
    { 'n', '<C-l>', [[:<C-U>lua require('Navigator').right()<CR>]] },
})

