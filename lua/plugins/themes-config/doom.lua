local function set (property, value)
    vim.g['doom_one_' .. property] = value
end

-- settings
set('terminal_colors',        true)
set('italic_comments',        true)
set('transparent_background', true)

-- activates the colorscheme
if colorscheme == 'doom-one' then 
    vim.cmd('colorscheme doom-one') 
    vim.cmd(appearance_cmds)
end

