" filenames/types where the plugin is enabled
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx'
let g:closetag_filetypes = 'html,xhtml,phtml,jsx,tsx'

" makes the non-closing tags self-closing in the specified filenames/types
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" makes the non-closing tags case-sensitive
let g:closetag_emptyTags_caseSensitive = 1

" disables auto-close if not in a 'valid' region (based on filetype)
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<leader>>'
