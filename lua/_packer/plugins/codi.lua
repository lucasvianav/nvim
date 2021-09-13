local function set (property, value)
    vim.g['codi#' .. property] = value
end

-- change the color
-- vim.cmd('highlight CodiVirtualText guifg=cyan')

-- use virtual text instead of new window
set('virtual_text', true) 
set('virtual_text_prefix', "❯ ")

set('autoclose', true)
set('aliases', {
    ['javascript.jsx'] = 'javascript',
    ['typescript.tsx'] = 'typescript',
})

