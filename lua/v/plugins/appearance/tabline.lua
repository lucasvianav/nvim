-- maybe swap for my own tabline
-- https://gitlab.com/yorickpeterse/dotfiles/-/blob/9b4aa6cf097015e156bbfa447f2324ece9a385ea/dotfiles/.config/nvim/lua/dotfiles/tabline.lua
require('tabline').setup({
    show_index = true, -- show tab index
    show_modify = true, -- show buffer modification indicator
    no_name = '[no name]', -- no name buffer name
})
