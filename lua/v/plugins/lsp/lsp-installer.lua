local lsp_installer = require('nvim-lsp-installer')
local lsp_installer_servers = require('nvim-lsp-installer.servers')
local utils = require('v.utils.lsp')

for _, server_name in ipairs(utils.servers) do
    local ok, server = lsp_installer_servers.get_server(server_name)

    if ok then
        if not server:is_installed() then
            server:install()
            vim.api.nvim_notify(
                server_name .. ' successfully installed.',
                vim.log.levels.INFO,
                { title = 'LspInstall' }
            )
        end

        local config = utils.make_config()

        local custom_config_path = 'v.plugins.lsp.servers.' .. server_name
        local has_custom_config, custom_config = pcall(require, custom_config_path)

        if has_custom_config then
            config = vim.tbl_deep_extend('force', config, custom_config)
        end

        if server_name == 'sumneko_lua' then
            local luadev_loaded, luadev = pcall(require, 'lua-dev')
            if luadev_loaded then
                config = luadev.setup({ lspconfig = config })
            end
        end

        server:setup(config)
    end
end

lsp_installer.on_server_ready(function()
    vim.api.nvim_command('do User LspAttachBuffers')
end)
