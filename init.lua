--[[
    INSPO:
    - https://github.com/tjdevries/config_manager/tree/master/xdg_config/nvim
    - https://github.com/lukas-reineke/dotfiles/tree/master/vim
    - https://github.com/akinsho/dotfiles/blob/main/.config/nvim
    - https://github.com/NvChad/NvChad
    - https://github.com/LunarVim/LunarVim
    - https://github.com/rockerBOO/dotfiles/tree/current/config/nvim
    - https://github.com/danielnehrig/nvim

    - https://www.youtube.com/channel/UCXPHFM88IlFn68OmLwtPmZA

    TODO: https://spacevim.org/SpaceVim-release-v1.8.0/#.YVsDlG_4ps8.reddit
    https://github.com/crivotz/nv-ide
    https://github.com/100lvlmaster/dots/tree/master
    https://www.youtube.com/watch?v=brtIZxOwDXE
    https://www.reddit.com/r/neovim/comments/qbmbj8/cosmicnvim_a_lightweight_and_opinionated_neovim/
    https://github.com/mattleong/CosmicNvim
    https://github.com/ecosse3/nvim
    https://github.com/albingroen/nvim-lsp-typescript-config

    TODO: setup cleaning for log.txt
    TODO: check if there are any plugins missing
    TODO: setup wrapper commands for :LspStuff
]]

pcall(require, 'impatient')

require('v.globals')
require('v.settings')
require('v.keybindings')
require('v.packer')
