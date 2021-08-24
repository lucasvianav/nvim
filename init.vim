" plugins
source $HOME/.config/nvim/general/plugins/index.vim

" general settings
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/providers.vim

" abbreviations
source $HOME/.config/nvim/mappings/typos.vim

" custom keybindings
source $HOME/.config/nvim/mappings/keybindings/general.vim
source $HOME/.config/nvim/mappings/keybindings/shortcuts.vim
source $HOME/.config/nvim/mappings/keybindings/navigation.vim
source $HOME/.config/nvim/mappings/keybindings/unmappings.vim

" custom commands
source $HOME/.config/nvim/mappings/commands/mappings.vim

" themes
source $HOME/.config/nvim/general/themes/appearence.vim
source $HOME/.config/nvim/general/themes/onedark.vim
source $HOME/.config/nvim/general/themes/airline.vim

" commands
source $HOME/.config/nvim/mappings/commands/BufClose.vim
source $HOME/.config/nvim/mappings/commands/BufOnly.vim
source $HOME/.config/nvim/mappings/commands/neovim.vim

" vim plugins
source $HOME/.config/nvim/general/plugins/config/closetag.vim
source $HOME/.config/nvim/general/plugins/config/coc.vim
source $HOME/.config/nvim/general/plugins/config/codi.vim
source $HOME/.config/nvim/general/plugins/config/easymotion.vim
source $HOME/.config/nvim/general/plugins/config/emmet.vim
source $HOME/.config/nvim/general/plugins/config/fzf.vim
source $HOME/.config/nvim/general/plugins/config/illuminate.vim
source $HOME/.config/nvim/general/plugins/config/quickscope.vim
source $HOME/.config/nvim/general/plugins/config/rainbow_parentheses.vim
source $HOME/.config/nvim/general/plugins/config/rnvimr.vim
source $HOME/.config/nvim/general/plugins/config/scalpel.vim
source $HOME/.config/nvim/general/plugins/config/startify.vim
source $HOME/.config/nvim/general/plugins/config/tmux-navigator.vim
source $HOME/.config/nvim/general/plugins/config/vim-commentary.vim
source $HOME/.config/nvim/general/plugins/config/vim-easy-align.vim
source $HOME/.config/nvim/general/plugins/config/vim-easyclip.vim
source $HOME/.config/nvim/general/plugins/config/vim-surround.vim
source $HOME/.config/nvim/general/plugins/config/vim-unimpaired.vim
source $HOME/.config/nvim/general/plugins/config/vim-visual-multi.vim
source $HOME/.config/nvim/general/plugins/config/vimtex.vim
source $HOME/.config/nvim/general/plugins/config/vimux.vim
source $HOME/.config/nvim/general/plugins/config/which-key.vim
" source $HOME/.config/nvim/general/plugins/config/nvim-telescope.vim

" lua plugins
lua require 'plug-colorizer'
lua require 'plug-bufferline'

" sessions config
source $HOME/.config/nvim/general/sessions.vim

" terminal config
source $HOME/.config/nvim/general/terminal.vim

