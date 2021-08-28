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

" commands
source $HOME/.config/nvim/mappings/commands/general.vim
source $HOME/.config/nvim/mappings/commands/abbreviations.vim
source $HOME/.config/nvim/mappings/commands/BufOnly.vim
source $HOME/.config/nvim/mappings/commands/BufClose.vim

" themes
source $HOME/.config/nvim/general/themes/appearence.vim
source $HOME/.config/nvim/general/themes/onedark.vim
source $HOME/.config/nvim/general/themes/airline.vim

" vim plugins
source $HOME/.config/nvim/general/plugins/config/closetag.vim
source $HOME/.config/nvim/general/plugins/config/coc.vim
source $HOME/.config/nvim/general/plugins/config/codi.vim
source $HOME/.config/nvim/general/plugins/config/commentary.vim
source $HOME/.config/nvim/general/plugins/config/easy-align.vim
source $HOME/.config/nvim/general/plugins/config/easyclip.vim
source $HOME/.config/nvim/general/plugins/config/easymotion.vim
source $HOME/.config/nvim/general/plugins/config/emmet.vim
source $HOME/.config/nvim/general/plugins/config/fzf.vim
source $HOME/.config/nvim/general/plugins/config/illuminate.vim
source $HOME/.config/nvim/general/plugins/config/pandoc-mardown-previewer.vim
source $HOME/.config/nvim/general/plugins/config/quickscope.vim
source $HOME/.config/nvim/general/plugins/config/rainbow_parentheses.vim
source $HOME/.config/nvim/general/plugins/config/rnvimr.vim
source $HOME/.config/nvim/general/plugins/config/scalpel.vim
source $HOME/.config/nvim/general/plugins/config/startify.vim
source $HOME/.config/nvim/general/plugins/config/surround.vim
source $HOME/.config/nvim/general/plugins/config/tmux-navigator.vim
source $HOME/.config/nvim/general/plugins/config/unimpaired.vim
source $HOME/.config/nvim/general/plugins/config/vimtex.vim
source $HOME/.config/nvim/general/plugins/config/vimux.vim
source $HOME/.config/nvim/general/plugins/config/visual-multi.vim
source $HOME/.config/nvim/general/plugins/config/which-key.vim

" lua plugins
lua require 'plug-colorizer'
lua require 'plug-bufferline'

" sessions config
source $HOME/.config/nvim/general/sessions.vim

