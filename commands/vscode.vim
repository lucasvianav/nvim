" Exit/Quit VSCode
command Exvs call VSCodeNotify("workbench.action.closeWindow")
command Qvs call VSCodeNotify("workbench.action.closeWindow")

" Discard unsaved changes
cnoremap e! call VSCodeNotify("workbench.action.files.revert")

" Reload VSCode window
command Rvs call VSCodeNotify("workbench.action.reloadWindow")

" Open VSCode's settings.json
command Settings call VSCodeNotify("workbench.action.openSettingsJson")

"Open VSCode's keybindings.json
command Keybindings call VSCodeNotify("workbench.action.openGlobalKeybindingsFile")
command Keyboard call VSCodeNotify("workbench.action.openGlobalKeybindingsFile")

" Commands I always get wrong
cabbrev Q Quit
cabbrev q1 Quit!
cabbrev wq Xit

AlterCommand qv[s] Qvs
AlterCommand r[vs] Rvs
AlterCommand settings Settings
AlterCommand keybindings Keybindings
AlterCommand keyboard Keyboard