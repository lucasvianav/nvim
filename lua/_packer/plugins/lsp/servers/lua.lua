local M = {}

local sumneko_root_path = vim.fn.stdpath('data') .. '/lspinstall/lua/sumneko_lua'
local sumneko_binary = sumneko_root_path .. '/lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

M.Lua = {
    cmd = {
        sumneko_binary,
        '-E',
        sumneko_root_path .. '/main.lua',
    },
    runtime = {
        version = 'LuaJIT',
        path = runtime_path,
    },
    diagnostics = {
        globals = {'vim'},
    },
    workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
    },
    telemetry = {
        enable = false,
    },
}

return M

