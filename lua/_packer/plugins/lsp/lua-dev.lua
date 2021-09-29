local sumneko_root_path = vim.fn.stdpath('data') .. '/lspinstall/lua/sumneko-lua'
local sumneko_binary = sumneko_root_path .. '-language-server'

local luadev = require('lua-dev').setup({
    lspconfig = lsp_make_config({
        cmd = {
            sumneko_binary,
            '-E',
            sumneko_root_path .. '/main.lua',
        },
    }),
})

-- luadev.settings.Lua.workspace.library["/usr/lib/pd/extra/pdlua"] = true

require('lspconfig').lua.setup(luadev)
