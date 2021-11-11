-- TODO: https://github.com/akinsho/dotfiles/blob/472005850403594c57fba5736a71760aae9b5e2e/.config/nvim/lua/as/plugins/init.lua#L322-L334

require('lsp_signature').steup({
    bind = true,
    floating_window = true,
    handler_opts = { border = 'single' },
    hint_enable = true,
    transparency = 10,
})
