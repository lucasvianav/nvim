" Plugins
source $HOME/.config/nvim/general/plugins.vim

" Settings
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/providers.vim

" Abbreviations
source $HOME/.config/nvim/general/typo-abbreviations.vim

" Keybind maps
source $HOME/.config/nvim/keybindings/mappings.vim
source $HOME/.config/nvim/keybindings/unimpaired.vim

"Command maps
source $HOME/.config/nvim/commands/mappings.vim

if exists('g:vscode') " if it's on vscode

    " VSCode settings
    source $HOME/.config/nvim/vscode/settings.vim

    " " glitch moves cursor to start of line when entering visual mode
    " source $HOME/.config/nvim/vscode/ui-modifier.vim

    " VSCode Keybinds
    source $HOME/.config/nvim/keybindings/vscode.vim

    " VSCode Commands
    source $HOME/.config/nvim/commands/vscode.vim

    " Plugins
    source $HOME/.config/nvim/plug-config/highlightedyank.vim

else " if it's not on vscode

    " Themes
    source $HOME/.config/nvim/themes/appearence.vim
    source $HOME/.config/nvim/themes/onedark.vim
    source $HOME/.config/nvim/themes/airline.vim

    " Non-VSCode Commands
    source $HOME/.config/nvim/commands/BufOnly.vim
    source $HOME/.config/nvim/commands/BufClose.vim
    source $HOME/.config/nvim/commands/neovim.vim

    " VIM Plugins
    source $HOME/.config/nvim/plug-config/coc.vim
    source $HOME/.config/nvim/plug-config/rnvimr.vim
    source $HOME/.config/nvim/plug-config/fzf.vim
    source $HOME/.config/nvim/plug-config/rainbow_parentheses.vim
    source $HOME/.config/nvim/plug-config/startify.vim
    source $HOME/.config/nvim/plug-config/codi.vim
    source $HOME/.config/nvim/plug-config/easymotion.vim
    source $HOME/.config/nvim/plug-config/closetag.vim
    source $HOME/.config/nvim/plug-config/illuminate.vim
    source $HOME/.config/nvim/plug-config/scalpel.vim

    " LUA Plugins
    lua require 'plug-colorizer'

    " Sessions config
    source $HOME/.config/nvim/general/sessions.vim

    " Terminal config
    source $HOME/.config/nvim/general/terminal.vim

endif

" Plugis used in both terminal Neovim and VSCode
source $HOME/.config/nvim/plug-config/quickscope.vim
source $HOME/.config/nvim/plug-config/vim-commentary.vim
source $HOME/.config/nvim/plug-config/vim-easyclip.vim
source $HOME/.config/nvim/plug-config/which-key.vim
source $HOME/.config/nvim/plug-config/vim-surround.vim

