-- TODO: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/plugins/lspconfig.lua
-- TODO: https://www.reddit.com/r/neovim/comments/qhaxg5/lsp_rename_changes_as_a_notification/

local lsp = vim.lsp

lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, {
    border = 'single',
})

lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, {
    border = 'single',
})

lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
    border = 'single',
    virtual_text = { source = 'always' }, -- or 'if_many'
    severity_sort = true,
    underline = true,
    update_in_insert = false,
})

-- lsp.handlers['textDocument/formatting'] = lsp_formatting_handler,
