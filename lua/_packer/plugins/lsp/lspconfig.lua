--{{ @HANDLERS
    lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, {
        border = 'single',
    })

    lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, {
        border = 'single',
    })

    lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
        border           = 'single',
        virtual_text     = { source = 'always' }, -- or 'if_many'
        severity_sort    = true,
        underline        = true,
        update_in_insert = false,
    })

    lsp.handlers['textDocument/formatting'] = lsp_formatting_handler,
-- @HANDLERS}}

