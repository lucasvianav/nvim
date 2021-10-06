local function set (property, value)
    vim.g['closetag_' .. property] = value
end

-- filenames/types where the plugin is enabled
set(filenames, '*.html,*.xhtml,*.phtml,*.jsx,*.tsx')
set(filetypes, 'html,xhtml,phtml,jsx,tsx')

-- makes the non-closing tags self-closing in the specified filenames/types
set(xhtml_filenames, '*.xhtml,*.jsx')
set(xhtml_filetypes, 'xhtml,jsx')

-- makes the non-closing tags case-sensitive
set(emptyTags_caseSensitive, 1)

-- disables auto-close if not in a 'valid' region
set(regions, {
    ['typescript.tsx']: 'jsxRegion,tsxRegion',
    ['javascript.jsx']: 'jsxRegion',
})

-- add > without closing the current tag
set(close_shortcut, '<leader>>')

