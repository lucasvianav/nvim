" hide cursorline when leaving window
augroup ManageCursorline
    au!
    au WinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
    au FileType TelescopePrompt setlocal nocursorline
augroup END

