require('lsp_signature').setup({
    bind = true,
    floating_window = true,
    floating_window_above_cur_line = true,
    hint_enable = false,
    toggle_key = '<M-s>',
    transparency = 100,

    handler_opts = {
        border = 'single',
    },

    fix_pos = function(signatures, client)
        local s = signatures[1]

        return client.name == 'sumneko_lua' or (s and s.activeParameter >= 0 and #s.parameters > 1)
    end,
})
