" opens init.vim
command! Settings e $MYVIMRC

" opens keybindings' mappings.vim
command! Keybindings ~/.config/nvim/keybindings/mappings.vim

" reloads init.vim
command! Rvimrc source $MYVIMRC

" saves current buffer and reloads init.vim
command! Wrvimrc w | source $MYVIMRC

" saves buffer and then closes it
command! BdWrite w | bd

" saves buffer and then closes it
command! BqWrite w | BufClose

" writes pdf text to a new buffer (works better for text-only)
command! -complete=file -nargs=1 Rpdf :enew | :r !pdftotext -nopgbrk <q-args> - |fmt -csw78

command DelSession normal <Plug>DeleteCurrentSession

cabbrev git Git
cabbrev r Rvimrc
cabbrev wrv Wrvimrc
cabbrev settings Settings
cabbrev keybindings Keybindings
cabbrev wbd BdWrite
cabbrev bufo BufOnly
cabbrev qb BufClose
cabbrev wqb BqWrite
