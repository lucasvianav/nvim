require('Navigator').setup({ disable_on_zoom = true })

-- use Ctrl + hjkl to navigate between vim windows and tmux planes
map('n', '<C-h>', [[:<C-U>lua require('Navigator').left()<CR>]])
map('n', '<C-j>', [[:<C-U>lua require('Navigator').down()<CR>]])
map('n', '<C-k>', [[:<C-U>lua require('Navigator').up()<CR>]])
map('n', '<C-l>', [[:<C-U>lua require('Navigator').right()<CR>]])

