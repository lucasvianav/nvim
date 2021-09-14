local M = {
    Lua = {
        runtime = {
            version = 'LuaJIT',
            path = vim.split(package.path, ';'),
        },
        diagnostics = { globals = {'vim'} },
        workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            -- library = {
            --     [ vim.fn.expand('$VIMRUNTIME/lua') ] = true,
            --     [ vim.fn.expand('$VIMRUNTIME/lua/vim/lsp') ] = true,
            -- },
        },
        telemetry = { enable = false },
    },
}

return M

