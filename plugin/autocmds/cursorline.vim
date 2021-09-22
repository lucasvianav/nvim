" hide cursorline when leaving window
augroup ManageCursorline
    au!
    au WinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

