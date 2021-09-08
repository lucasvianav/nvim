local function set (property, value)
    vim.g['nord_' .. property] = value
end

-- settings
set('contrast',                  false)    -- different bg for popup and menus
set('borders',                   true)     -- vertical borders between windows
set('disable_background',        true)
set('cursorline_transparent',    false)
set('enable_sidebar_background', false)    -- if background was disabled
set('italic',                    true)     -- if background was disabled

-- activates the colorscheme
if colorscheme == 'nord' then 
    vim.cmd('colorscheme nord') 
    vim.cmd(appearance_cmds)
end

