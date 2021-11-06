-- TODO: write command to clear swap files
-- TODO: write command to delete current file's swap file

require('v.commands.abbreviations')

require('v.utils.commands').set_commands({
    -- how many times does this pattern appear in the file
    { 'Count', 'keeppatterns %s/<args>//gn | noh', { nargs = 1 } },

    -- saves buffer and then closes it
    { 'BqWrite', 'update | BufClose' },

    -- LSP
    { 'Format', 'lua vim.lsp.buf.formatting_sync({}, 1000)' },
    { 'FT', 'lua vim.lsp.buf.formatting_sync({}, 1000)' },
    { 'LQF', 'lua vim.diagnostic.setqflist()' },

    -- wrappers
    { 'P', 'lua require("v.utils.wrappers").inspect(<args>)', { nargs = 1 } },
    { 'R', 'lua require("v.utils").reload_or_source_current()' },
})
