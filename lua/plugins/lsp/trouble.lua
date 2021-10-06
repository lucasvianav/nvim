require('trouble').setup({
    position     = 'bottom',
    icons        = true,
    mode         = 'lsp_workspace_diagnostics', -- 'lsp_workspace_diagnostics', 'lsp_document_diagnostics', 'quickfix', 'lsp_references', 'loclist'
    indent_lines = true,
    auto_open    = false,
    auto_close   = true, -- when no diagnostics
    auto_preview = true,
    auto_fold    = false,

    use_lsp_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client

    action_keys = {
        close          = 'q',
        cancel         = {  '<c-c>', '<esc>' },
        refresh        = 'r',
        jump           = { '<cr>', '<tab>' },
        open_split     = { '<c-x>', 's', 'h' },
        open_vsplit    = { '<c-v>', 'v' },
        open_tab       = { '<c-t>', 't' },
        jump_close     = { 'o' },
        toggle_mode    = 'm', -- toggle between 'workspace' and 'document' diagnostics mode
        toggle_preview = 'P', -- toggle auto_preview
        hover          = 'gh', -- opens a small popup with the full multiline message
        preview        = 'p',
        close_folds    = { 'zM', 'zm' },
        open_folds     = { 'zR', 'zr' },
        toggle_fold    = { 'zA', 'za' },
        previous       = { 'k', '<c-k>' },
        next           = { 'j', '<c-j>' },
    },

    signs = {
        error       = '',
        warning     = '',
        hint        = '',
        information = '',
        other       = '﫠',
    },
})
