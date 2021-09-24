local M = {}

local sumneko_root_path = vim.fn.stdpath('data') .. '/lspinstall/lua/sumneko-lua'
local sumneko_binary = sumneko_root_path .. '/lua-language-server'

-- local sumneko_root_path = vim.fn.stdpath('data') .. '/lspinstall/lua/sumneko-lua/extension/server'
-- local sumneko_binary =  vim.fn.stdpath('data') .. '/lspinstall/lua/lua-language-server'

local lib = {}
local function add(libr)
    local tbl = type(libr) == 'table'
        and libr
        or vim.fn.expand(libr, false, true)

    for _, p in pairs(tbl) do
        p = vim.loop.fs_realpath(vim.fn.expand(p))
        if p then
            lib[p] = true
        end
    end
end

add('$VIMRUNTIME')
add('$VIMRUNTIME/lua')
add('$VIMRUNTIME/lua/vim/lsp')
add(vim.fn.stdpath('config'))
add(vim.api.nvim_get_runtime_file('', true))



local runtime_path = {
    'lua/?.lua',
    'lua/?/init.lua',
}

vim.tbl_extend('keep', runtime_path, vim.split(package.path, ';'))

for libr, _ in pairs(lib) do
    table.insert(runtime_path, libr .. "/?.lua")
    table.insert(runtime_path, libr .. "/?/init.lua")
end



-- M.cmd = {
--     sumneko_binary,
--     '-E',
--     sumneko_root_path .. '/main.lua',
-- }

M.settings = {
    Lua = {
        runtime = {
            version = 'LuaJIT',
            path = runtime_path,
        },
        diagnostics = {
            globals = {'vim'},
        },
        workspace   = {
            library = lib,
            maxPreload = 1000,
            preloadFileSize = 150,
        },
        telemetry   = {
            enable  = false,
        },
    },
}

M.on_new_cnofig = function(config, root_dir)
    local lib = vim.tbl_deep_extend("force", {}, config.settings.Lua.workspace.library)
    lib[vim.loop.fs_realpath(root_dir) .. "/lua"] = nil
    lib[vim.loop.fs_realpath(root_dir)]           = nil

    config.settings.Lua.workspace.library = lib
    return config
end

return M

