local desired_lsp_servers = {
    'angular',
    'bash',
    'cpp',
    'css',
    'dockerfile',
    'efm',
    'graphql',
    'html',
    'json',
    'lua',
    -- 'python',
    'typescript',
    'vim',
}

--------------------------------------------------------------------------------

local lsp = vim.lsp

local function setup_jedi()
    local jedi_config = require('lspinstall.util').extract_config('jedi_language_server')
    jedi_config.default_config.cmd[1] = './venv/bin/jedi-language-server'

    require('lspinstall.servers').jedi = vim.tbl_extend('error', jedi_config, {
        install_script = [[
        python3 -m venv ./venv
        ./venv/bin/pip3 install --upgrade pip
        ./venv/bin/pip3 install --upgrade jedi-language-server
        ]],
    })
end

-- loads all installed servers
local function setup_servers()
    setup_jedi()

    local lspinstall = require('lspinstall')
    lspinstall.setup()

    local servers = lspinstall.installed_servers()
    for _, server in pairs(servers) do
        if server ~= 'lua' then
            local config = require('v.utils.lsp').lsp_make_config()

            local custom_config_path = 'v.plugins.lsp.servers.' .. server
            local has_custom_config, custom_config = pcall(require, custom_config_path)

            if has_custom_config then
                config = vim.tbl_deep_extend('force', config, custom_config)
            end

            require('lspconfig')[server].setup(config)
        end
    end
end

local lspinstall = require('lspinstall')
local installed = lspinstall.installed_servers() -- all installed servers

-- installs all needed servers on startup
for _, server in pairs(desired_lsp_servers) do
    if not contains(server, installed) then
        lspinstall.install_server(server)
        print('LspInstall: ' .. server .. ' successfully installed.')
    end
end

setup_servers()

-- setup the new server and restart
-- on all buffers after install
lspinstall.post_install_hook = function()
    setup_servers()
    vim.cmd('windo e')
end

vim.lsp.diagnostic.set_signs = set_signs_limited

-- show line diagnostics automatically in hover window
-- vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]])
