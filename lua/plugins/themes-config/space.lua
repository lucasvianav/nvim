-- settings
vim.g.space_nvim_transparent_bg = true

-- activates the colorscheme
if colorscheme == 'space-nvim' then 
    vim.cmd('colorscheme space-nvim') 
    vim.cmd(appearance_cmds)
end

