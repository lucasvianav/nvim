local M = {}

--- Language servers to keep installed
M.servers = {
    'angularls',
    'bashls',
    'clangd',
    'cssls',
    'dockerls',
    'efm',
    'emmet_ls',
    -- 'eslint',
    'graphql',
    'html',
    'jedi_language_server',
    'jsonls',
    'sqls',
    'sqlls',
    'sumneko_lua',
    'tsserver',
    'vimls',
}

--- General diagnostics settings
vim.diagnostic.config({
    virtual_text = { source = 'always' }, -- or 'if_many'
    severity_sort = true,
    underline = true,
    update_in_insert = false,
    float = {
        scope = 'line',
        border = 'single',
    },
})

return M
