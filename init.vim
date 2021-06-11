" plugins
source $HOME/.config/nvim/general/plugins/index.vim

" general settings
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/providers.vim

" abbreviations
source $HOME/.config/nvim/mappings/typos.vim

" custom keybindings
source $HOME/.config/nvim/mappings/keybindings/mappings.vim
source $HOME/.config/nvim/mappings/keybindings/unimpaired.vim

" custom commands
source $HOME/.config/nvim/mappings/commands/mappings.vim

if exists('g:vscode') " if it's on vscode

    " vscode settings
    source $HOME/.config/nvim/vscode/settings.vim

    " " glitch moves cursor to start of line when entering visual mode
    " source $HOME/.config/nvim/vscode/ui-modifier.vim

    " vscode keybinds
    source $HOME/.config/nvim/mappings/keybindings/vscode.vim

    " vscode commands
    source $HOME/.config/nvim/mappings/commands/vscode.vim

    " plugins
    source $HOME/.config/nvim/general/plugins/config/highlightedyank.vim

else " if it's not on vscode

    " themes
    source $HOME/.config/nvim/general/themes/appearence.vim
    source $HOME/.config/nvim/general/themes/onedark.vim
    source $HOME/.config/nvim/general/themes/airline.vim

    " non-vscode commands
    source $HOME/.config/nvim/mappings/commands/BufOnly.vim
    source $HOME/.config/nvim/mappings/commands/BufClose.vim
    source $HOME/.config/nvim/mappings/commands/neovim.vim

    " vim plugins
    source $HOME/.config/nvim/general/plugins/config/coc.vim
    source $HOME/.config/nvim/general/plugins/config/rnvimr.vim
    source $HOME/.config/nvim/general/plugins/config/fzf.vim
    source $HOME/.config/nvim/general/plugins/config/rainbow_parentheses.vim
    source $HOME/.config/nvim/general/plugins/config/startify.vim
    source $HOME/.config/nvim/general/plugins/config/codi.vim
    source $HOME/.config/nvim/general/plugins/config/easymotion.vim
    source $HOME/.config/nvim/general/plugins/config/closetag.vim
    source $HOME/.config/nvim/general/plugins/config/illuminate.vim
    source $HOME/.config/nvim/general/plugins/config/scalpel.vim

    " lua plugins
    lua require 'plug-colorizer'

    " sessions config
    source $HOME/.config/nvim/general/sessions.vim

    " terminal config
    source $HOME/.config/nvim/general/terminal.vim

endif

" plugis used in both terminal neovim and vscode
source $HOME/.config/nvim/general/plugins/config/quickscope.vim
source $HOME/.config/nvim/general/plugins/config/vim-commentary.vim
source $HOME/.config/nvim/general/plugins/config/vim-easyclip.vim
source $HOME/.config/nvim/general/plugins/config/which-key.vim
source $HOME/.config/nvim/general/plugins/config/vim-surround.vim

