local desired_lsp_servers = {
    'angular',
    'bash',
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

--------------------------------

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
    buf_set_keymap('n', 'gi',        '<cmd>lua vim.lsp.buf.implementation()<CR>',                             opts)
    -- buf_set_keymap('n', '<C-k>',     '<cmd>lua vim.lsp.buf.signature_help()<CR>',                             opts)
    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',                       opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',                    opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D',  '<cmd>lua vim.lsp.buf.type_definition()<CR>',                            opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>',                                     opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',                                opts)
    buf_set_keymap('n', 'gr',        '<cmd>lua vim.lsp.buf.references()<CR>',                                 opts)
    -- buf_set_keymap('n', '<space>e',  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',               opts)
    -- buf_set_keymap('n', '[d',        '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',                           opts)
    -- buf_set_keymap('n', ']d',        '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',                           opts)
    -- buf_set_keymap('n', '<space>q',  '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',                         opts)
    -- buf_set_keymap('n', '<space>f',  '<cmd>lua vim.lsp.buf.formatting()<CR>',                                 opts)
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
        require('lspconfig')[server].setup(make_config()) 
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
    vim.cmd('bufdo e')
end

