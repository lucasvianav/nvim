" count the pattern
command! -nargs=1 Count keeppatterns %s/<args>//gn | noh

" saves buffer and then closes it
command! BqWrite w | BufClose

" TODO; use this?
" Save even if we forgot to open the file with sudo
" cmap w!! %!sudo tee > /dev/null %

" TODO: write command to clear swap files
" TODO: write command to delete current file's swap file
