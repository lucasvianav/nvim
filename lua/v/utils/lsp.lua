-- TODO: override renaming handler https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lsp/rename.lua
-- TODO: diagnostics https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lsp/diagnostics.lua#L15

local lsp = vim.lsp
local fn = vim.fn
local api = vim.api

local M = {}

M.servers = {
    'angularls',
    'bashls',
    'clangd',
    'cssls',
    'dockerls',
    'efm',
    'emmet_ls',
    'eslint',
    'graphql',
    'html',
    'jedi_language_server',
    'jsonls',
    'sumneko_lua',
    'tsserver',
    'vimls',
}

local function __peek_definitin_callback(_, result)
    if result == nil or vim.tbl_isempty(result) then
        return nil
    end

    lsp.util.preview_location(result[1])
end

--- Peek definition for symbl below the cursor. Similar to VSCode's Peek
--- Definition.
function M.peek_definition()
    return vim.lsp.buf_request(
        0,
        'textDocument/definition',
        lsp.util.make_position_params(),
        __peek_definitin_callback
    )
end

--- Function for LSP's 'textDocument/formatting' handler.
--- (not working for some reason?)
function M.formatting(err, _, result, _, bufnr)
    if err ~= nil or result == nil then
        return
    end

    if not api.nvim_buf_get_option(bufnr, 'modified') then
        local view = fn.winsaveview()
        lsp.util.apply_text_edits(result, bufnr)
        fn.winrestview(view)

        if bufnr == api.nvim_get_current_buf() then
            api.nvim_command('noautocmd :update')
        else
            api.nvim_notify('Formatted buffer ' .. bufnr, 2, { title = 'LSP --- Formatting' })
        end
    end
end

function M.typescript_sort_imports(bufnr, post)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    local METHOD = 'workspace/executeCommand'
    local params = {
        command = '_typescript.organizeImports',
        arguments = { vim.api.nvim_buf_get_name(bufnr) },
        title = '',
    }

    local callback = function(err)
        if not err and post then
            post()
        end
    end

    vim.lsp.buf_request(bufnr, METHOD, params, callback)
end

--- Disables formatting capabilities for an LSP client.
--- @param client table
local function disable_formatting(client)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
end

local __specific_on_attach = {
    tsserver = function(client, bufnr)
        local function buf_set_keymap(...)
            local args = { ... }
            api.nvim_buf_set_keymap(bufnr, args[1], args[2], args[3], {
                noremap = true,
                silent = true,
            })
        end

        disable_formatting(client)
        client.resolved_capabilities.rename = false

        -- TODO: can I organize imports without ts-utils?
        -- https://github.com/mrjones2014/dotfiles/blob/6159bc2ddfae95af8eed57109b416c37868199a7/.config/nvim/lua/modules/lsp-utils.lua#L57-L73
        -- TODO: port this https://github.com/SoominHan/import-sorter
        local has_ts_utils, ts_utils = pcall(require, 'nvim-lsp-ts-utils')

        if has_ts_utils then
            ts_utils.setup({
                enable_import_on_completion = true,
                import_all_scan_buffers = 100,

                -- eslint
                eslint_enable_code_actions = true,
                eslint_enable_disable_comments = true,
                eslint_bin = 'eslint_d',
                eslint_enable_diagnostics = true,

                -- formatting
                formatter = 'eslint_d',
                -- formatter = 'prettier',
                formatter_opts = {},

                -- update imports on file move
                update_imports_on_move = false,
            })

            ts_utils.setup_client(client)

            local work_dir = os.getenv('WORK_DIR')
            local regexp = vim.regex('^' .. fn.escape(work_dir, '.'))
            local cwd = fn.getcwd()

            -- sets up auto-sorting of imports if not on $WORK_DIR
            if fn.empty(work_dir) == 1 or not regexp:match_str(cwd) then
                api.nvim_exec(
                    [[
                        augroup SortImports
                        au! * <buffer>
                        au BufWritePre <buffer> TSLspOrganizeSync
                        augroup END
                    ]],
                    false
                )
            end

            buf_set_keymap('n', '<leader>si', '<cmd>TSLspOrganize<CR>')
        end
        -- buf_set_keymap('n', '<leader>si', '<cmd>lua typescript_sort_imports(' .. bufnr .. ')<CR>')
    end,

    efm = function(client, bufnr)
        client.resolved_capabilities.document_formatting = true
        client.resolved_capabilities.document_range_formatting = true
        client.resolved_capabilities.hover = false
        client.resolved_capabilities.rename = false
    end,

    angularls = disable_formatting,
    cssls = disable_formatting,
    eslint = disable_formatting,
    graphql = disable_formatting,
    html = disable_formatting,
    jedi_language_server = disable_formatting,
    jsonls = disable_formatting,
    sumneko_lua = disable_formatting,
    vimls = disable_formatting,
}

--- Setup autcommands based on LSP client's characteristics.
--- @param client table
local function __conditional_autocmds(client)
    if client.resolved_capabilities.document_highlight then
        api.nvim_exec(
            [[
                augroup lsp_document_highlight
                au! * <buffer>
                au CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
                au CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]],
            false
        )
    end

    if client.resolved_capabilities.document_formatting then
        api.nvim_exec(
            [[
                augroup AutoFormat
                au! * <buffer>
                au BufWritePost <buffer> lua vim.lsp.buf.formatting()
                augroup END
            ]],
            false
        )
    end

    if client.name == 'eslint' then
        vim.api.nvim_exec(
            [[
                augroup AutoFormatEslint
                au! * <buffer>
                au BufWritePre <buffer> EslintFixAll
                augroup END
            ]],
            false
        )
    end
end

--- Calls LSP hover or activates Vim doc (`:h`) depending on filetype.
function M.show_documentation()
    if vim.tbl_contains({ 'vim', 'help', 'lua' }, vim.o.filetype) then
        vim.api.nvim_command('h ' .. vim.fn.expand('<cword>'))
    else
        vim.lsp.buf.hover()
    end
end

local function __on_attach(client, bufnr)
    local opts = { buffer = true, bufnr = bufnr }

    require('v.utils.mappings').set_keybindings({
        { 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts },
        { 'n', '<leader>gp', '<cmd>lua require("v.utils.lsp").peek_definition()<CR>', opts },
        { 'n', '<space>e', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', opts },
        { 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts },
        { 'n', 'K', '<cmd>lua require("v.utils.lsp").show_documentation()<CR>', opts },
        { 'n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts },
        { 'n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts },
        { 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts },
        { 'n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts },
        { 'n', 'gq', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts },
    })

    -- enable completion triggered by <c-x><c-o>
    api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    if __specific_on_attach[client.name] then
        __specific_on_attach[client.name](client, bufnr)
    end

    __conditional_autocmds(client)
end

--- Generates a language server config to be passed into `nvim-lspconfig`,
--- enabling snippets and including autcompletion plugin stuff.
--- @param config? table
--- @return table
function M.make_config(config)
    local capabilities = lsp.protocol.make_client_capabilities()

    -- enable snippets
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            'documentation',
            'detail',
            'additionalTextEdits',
        },
    }
    capabilities.textDocument.completion.completionItem.preselectSupport = true
    capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
    capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
    capabilities.textDocument.completion.completionItem.deprecatedSupport = true
    capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
    capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }

    config = vim.tbl_deep_extend('keep', config or {}, {
        capabilities = capabilities,
        on_attach = __on_attach,
    })

    local has_coq, coq = pcall(require, 'coq')
    if has_coq then
        config = coq.lsp_ensure_capabilities(config)
    end

    return config
end

return M
