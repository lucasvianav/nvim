--TODO: use `assert` to check for argument types
--
--TODO:
--https://spacevim.org/SpaceVim-release-v1.8.0/#.YVsDlG_4ps8.reddit
--https://github.com/crivotz/nv-ide
--https://github.com/100lvlmaster/dots/tree/master
--https://www.youtube.com/watch?v=brtIZxOwDXE
--https://www.reddit.com/r/neovim/comments/qbmbj8/cosmicnvim_a_lightweight_and_opinionated_neovim/
--https://github.com/albingroen/nvim-lsp-typescript-config
--https://github.com/shaeinst/roshnivim
--https://github.com/ayamir/nvimdots
--https://github.com/kyle-mccarthy/nvim-dotfiles
--https://github.com/bfredl/bfredl.github.io/tree/master/nvim
--https://github.com/kabouzeid
-- https://github.com/lewis6991/dotfiles/tree/master/config/nvim

-- TODO: https://github.com/tjdevries/lazy-require.nvim

pcall(require, "impatient")

require("v.globals")
require("v.settings")
require("v.keybindings")
require("v.commands")
require("v.packer")
