-- TODO: override renaming handler https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lsp/rename.lua
-- TODO: diagnostics https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lsp/diagnostics.lua#L15
-- TODO: https://www.reddit.com/r/neovim/comments/p0jx12/weird_diagnostic_signs_behavior/h898ft6/?utm_source=reddit&utm_medium=web2x&context=3
-- TODO: remove this from plugin config
-- TODO: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/plugins/lspconfig.lua

local lsp = vim.lsp

--{{ @HANDLERS
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
-- @HANDLERS}}
