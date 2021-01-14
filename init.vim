" Plugin Manager
source $HOME/.config/nvim/vim-plug/plugins.vim

" Settings
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/providers.vim

" Keymaps
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/keys/which-key.vim

if exists('g:vscode') " if it's on vscode
    
    " vscode settings
    source $HOME/.config/nvim/vscode/settings.vim
    
    " Plugins
    source $HOME/.config/nvim/plug-config/easymotion.vim
    source $HOME/.config/nvim/plug-config/highlightyank.vim

else " if it's not on vscode
    
    " Themes
    source $HOME/.config/nvim/themes/onedark.vim
    source $HOME/.config/nvim/themes/airline.vim

    " VIM Plugins
    source $HOME/.config/nvim/plug-config/coc.vim
    source $HOME/.config/nvim/plug-config/rnvimr.vim
    source $HOME/.config/nvim/plug-config/vim-commentary.vim
    source $HOME/.config/nvim/plug-config/fzf.vim
    source $HOME/.config/nvim/plug-config/rainbow_parentheses.vim
    source $HOME/.config/nvim/plug-config/start-screen.vim
    source $HOME/.config/nvim/plug-config/quickscope.vim
    source $HOME/.config/nvim/plug-config/sneak.vim
    source $HOME/.config/nvim/plug-config/codi.vim

    " LUA Plugins
    lua require 'plug-colorizer'

endif
