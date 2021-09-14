local desired_lsp_servers = {
    'angular',
    'bash',
    'cpp',
    'css',
    'dockerfile',
    'graphql',
    'html',
    'json',
    'lua',
    'python',
    'typescript',
    'vim',
}






--------------------------------------------------------------------------------






local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true }

    -- mappings
    buf_set_keymap('n', 'gD',        '<cmd>lua vim.lsp.buf.declaration()<CR>',                                opts)
    buf_set_keymap('n', 'gd',        '<cmd>lua vim.lsp.buf.definition()<CR>',                                 opts)
    buf_set_keymap('n', 'gh',         '<cmd>lua vim.lsp.buf.hover()<CR>',                                      opts)
    -- buf_set_keymap('n', '<C-k>',     '<cmd>lua vim.lsp.buf.signature_help()<CR>',                             opts)
    buf_set_keymap('n', '<space>D',  '<cmd>lua vim.lsp.buf.type_definition()<CR>',                            opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>',                                     opts)
    -- buf_set_keymap('n', '<space>e',  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',               opts)
    -- buf_set_keymap('n', '[d',        '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',                           opts)
    -- buf_set_keymap('n', ']d',        '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',                           opts)
    -- buf_set_keymap('n', '<space>q',  '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',                         opts)
    -- buf_set_keymap('n', '<space>f',  '<cmd>lua vim.lsp.buf.formatting()<CR>',                                 opts)

    -- set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
    end
end

-- config that activates keymaps and enables snippet support
local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    return {
        capabilities = capabilities, -- enable snippet support
        on_attach    = on_attach,    -- map keybindings when the server attaches
    }
end

-- loads all installed servers
local function setup_servers()
    local lspinstall = require('lspinstall')
    lspinstall.setup()

    local servers = lspinstall.installed_servers()
    for _, server in pairs(servers) do
        local config = make_config()

        if server == 'lua' then
            config.settings = require('_packer.plugins.lsp.servers').lua
        end

        require('lspconfig')[server].setup(config) 
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
vim.cmd('windo e')

-- setup the new server and restart
-- on all buffers after install
lspinstall.post_install_hook = function()
    setup_servers()
    vim.cmd('bufdo e')
end

