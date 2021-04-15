" Exit/Quit VSCode
cnoremap exvs call VSCodeNotify("workbench.action.closeWindow")
cnoremap qvs call VSCodeNotify("workbench.action.closeWindow")
cnoremap qv call VSCodeNotify("workbench.action.closeWindow")

" Discard unsaved changes
cnoremap e! call VSCodeNotify("workbench.action.files.revert")

" Reload VSCode window
cnoremap rvs call VSCodeNotify("workbench.action.reloadWindow")
cnoremap rv call VSCodeNotify("workbench.action.reloadWindow")
cnoremap Rvs call VSCodeNotify("workbench.action.reloadWindow")
cnoremap Rv call VSCodeNotify("workbench.action.reloadWindow")

" Open VSCode's settings.json
cnoremap settings call VSCodeNotify("workbench.action.openSettingsJson")

"Open VSCode's keybindings.json
cnoremap keybindings call VSCodeNotify("workbench.action.openGlobalKeybindingsFile")
cnoremap keyboard call VSCodeNotify("workbench.action.openGlobalKeybindingsFile")