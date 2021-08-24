command! -nargs=1 Count :%S/<args>//gn | noh

" opens init.vim
command! Settings e $MYVIMRC

" reloads init.vim
command! Rvimrc source $MYVIMRC

" saves current buffer and reloads init.vim
command! Wrvimrc w | source $MYVIMRC

" saves buffer and then closes it
command! BdWrite w | bd

" saves buffer and then closes it
command! BqWrite w | BufClose

" deletes current session
command! DelSession normal <Plug>DeleteCurrentSession

