local M = {
    buf = {
        declaration     = { 'n',  'gD'        },
        definition      = { 'n',  'gd'        },
        hover           = { 'n',  'gh'        },
        implementation  = { 'n',  'gi'        },
        signature_help  = { 'n',  '<C-k>'     },
        type_definition = { 'n',  '<space>D'  },
        rename          = { 'n',  '<space>rn' },
        code_action     = { 'n',  '<space>ca' },
        references      = { 'n',  'gr'        },
        formatting      = { 'n', '<space>f'   },
    },

    diagnostic = {
        show_line_diagnostics = { 'n', '<space>e' },
        goto_prev             = { 'n', '[d'       },
        goto_next             = { 'n', ']d'       },
        set_loclist           = { 'n', '<space>q' },
    }
}

return M

