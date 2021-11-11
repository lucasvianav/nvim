-- TODO: activate for Lua

require('v.utils').set_viml_options('codi#', {
    -- use virtual text instead of new window
    virtual_text = true,
    virtual_text_prefix = ' ',

    autoclose = true,
    aliases = {
        ['javascript.jsx'] = 'javascript',
        ['typescript.tsx'] = 'typescript',
    },
})

-- change the color
-- vim.cmd('highlight CodiVirtualText guifg=cyan')
