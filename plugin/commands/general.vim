" count the pattern
command! -nargs=1 Count keeppatterns %s/<args>//gn | noh

" saves buffer and then closes it
command! BqWrite w | BufClose

