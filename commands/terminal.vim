" opens init.vim
command Settings e $MYVIMRC

" opens keybindings' mappings.vim
command Keybindings ~/.config/nvim/keybindings/mappings.vim

" reloads init.vim
command Rvimrc source $MYVIMRC

" saves current buffer and reloads init.vim
command -bar WRITEBAR write
command Wrvimrc WRITEBAR|source $MYVIMRC

" maybe reopens last closed buffer
command UndoQuit e #

cabbrev git Git
cabbrev r Rvimrc
cabbrev wrv Wrvimrc
cabbrev settings Settings
cabbrev keybindings Keybindings
cabbrev uq UndoQuit
