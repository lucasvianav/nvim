require('v.utils').set_viml_options('UltiSnips', {
    EditSplit = 'tab',
    ExpandTrigger = '<tab>',
    JumpBackwardTrigger = '<s-tab>',
    JumpForwardTrigger = '<tab>',
    ListSnippets = '<c-x><c-x>',
    SnippetDirectories = {
        vim.fn.stdpath('data') .. '/snippets',
    },
})
