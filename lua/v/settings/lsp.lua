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
    severity_sort = true,
    underline = true,
    update_in_insert = false,
    float = {
        scope = 'line',
        border = 'single',
        source = 'always',
        focusable = false,
        close_events = {
            'BufLeave',
            'CursorMoved',
            'InsertEnter',
            'FocusLost',
        },
    },
    virtual_text = {
        source = 'always',
    },
})

return M
