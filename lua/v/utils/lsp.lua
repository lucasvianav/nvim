local lsp = vim.lsp
local fn = vim.fn
local api = vim.api
local cmd = vim.api.nvim_command

local M = {}

--- Language servers to keep installed
M.servers = {
    -- TODO: find out why isn't working
    -- 'angularls',
    'bashls',
    'clangd',
    'cssls',
    'dockerls',
    'efm',
    'emmet_ls',
    -- 'eslint',
    'graphql',
    'html',
    'jedi_language_server',
    'jsonls',
    'sumneko_lua',
    'tsserver',
    'vimls',
}

--- Function for LSP's 'textDocument/formatting' handler.
--- @param err table
--- @param ctx table
--- @param config table
function M.formatting(err, result, ctx, config)
    if err ~= nil or result == nil then
        return
    end

    local bufnr = ctx.bufnr

    if not api.nvim_buf_get_option(bufnr, 'modified') then
        local view = fn.winsaveview()
        lsp.util.apply_text_edits(result, bufnr)
        fn.winrestview(view)

        if bufnr == api.nvim_get_current_buf() then
            api.nvim_command('noautocmd :update')
        else
            api.nvim_notify(
                'Formatted buffer ' .. bufnr,
                vim.log.levels.INFO,
                { title = 'LSP --- Formatting' }
            )
        end
    end
end

local __rename_prompt = 'Rename   '

local function __rename_handler(...)
    local err = select(1, ...)
    local is_new = not select(4, ...) or type(select(4, ...)) ~= 'number'

    local result
    local method

    if is_new then
        method = select(3, ...).method
        result = select(2, ...)
    else
        method = select(2, ...)
        result = select(3, ...)
    end

    if err then
        vim.api.nvim_notify(
            ("Error running LSP query '%s': %s"):format(method, err),
            vim.log.levels.ERROR,
            { title = 'LSP --- Renaming' }
        )
        return
    end

    -- notify the files in which the change happened
    if result and result.changes and #result.changes > 1 then
        local new_word = ''
        local msg = ''

        for file, change in pairs(result.changes) do
            new_word = change[1].newText
            msg = msg
                .. ('%d changes -> %s'):format(#change, require('v.utils').get_relative_path(file))
                .. '\n'
        end

        local currName = vim.fn.expand('<cword>')
        msg = msg:sub(1, #msg - 1)
        vim.notify(
            msg,
            vim.log.levels.INFO,
            { title = ('Rename: %s =>> %s'):format(currName, new_word) }
        )
    end

    vim.lsp.handlers[method](...)
end

--- Confirms/declines the renaming.
function M.rename_callback()
    local new_name = vim.trim(vim.fn.getline('.'):sub(#__rename_prompt + 1, -1))
    cmd([[stopinsert]])
    cmd([[bd!]])

    if new_name and #new_name > 0 and new_name ~= vim.fn.expand('<cword>') then
        local params = vim.lsp.util.make_position_params()
        params.newName = new_name
        vim.lsp.buf_request(0, 'textDocument/rename', params, __rename_handler)
    end
end

-- TODO: https://github.com/filipdutescu/renamer.nvim
-- TODO: https://github.com/neovim/neovim/commit/16d4af6d2f549709aa55510f5ae52238c5cadb9c
--- Custom rename prompt for symbol below cursor.
function M.rename()
    local current_name = vim.fn.expand('<cword>')
    local bufnr = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_option(bufnr, 'buftype', 'prompt')
    vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'wipe')
    vim.api.nvim_buf_add_highlight(bufnr, -1, 'RenamePrompt', 0, 0, #__rename_prompt)

    vim.fn.prompt_setprompt(bufnr, __rename_prompt)
    local winnr = vim.api.nvim_open_win(bufnr, true, {
        relative = 'cursor',
        width = 50,
        height = 1,
        row = -3,
        col = 1,
        style = 'minimal',
        border = 'single',
    })

    vim.api.nvim_win_set_option(winnr, 'winhl', 'Normal:Floating')
    vim.api.nvim_win_set_option(winnr, 'cursorline', false)
    vim.api.nvim_win_set_option(winnr, 'scrolloff', 0)

    local opts = { buffer = true }
    require('v.utils.mappings').set_keybindings({
        { 'n', '<ESC>', '<cmd>bd!<CR>', opts },
        { 'n', '<C-C>', '<cmd>bd!<CR>', opts },
        { { 'n', 'i' }, '<CR>', "<cmd>lua require('v.utils.lsp').rename_callback()<CR>", opts },
        { 'i', '<BS>', '<ESC>"_xi', opts },
    })

    cmd('normal i' .. current_name)
end

local function __peek_definitin_callback(_, result)
    if result == nil or vim.tbl_isempty(result) then
        return nil
    end

    lsp.util.preview_location(result[1])
end

-- TODO: https://www.reddit.com/r/neovim/comments/qpfc25/telescope_preview_definition/
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
--- @param client table lsp client
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
        -- TODO: uncomment when angularls works
        -- client.resolved_capabilities.rename = false

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
--- @param client table lsp client
local function __conditional_autocmds(client)
    local augroup = require('v.utils.autocmds').augroup

    if client.resolved_capabilities.document_highlight then
        augroup('LspSymbolHighlight', {
            { 'CursorHold', '<buffer>', 'lua vim.lsp.buf.document_highlight()' },
            { 'CursorHoldI', '<buffer>', 'lua vim.lsp.buf.document_highlight()' },
            { 'CursorMoved', '<buffer>', 'lua vim.lsp.buf.clear_references()' },
        })
    end

    if client.resolved_capabilities.document_formatting then
        augroup('AutoFormat', {
            { 'BufWritePost', '<buffer>', 'lua vim.lsp.buf.formatting()' },
        })
    end

    if client.name == 'eslint' then
        augroup('AutoFormatEslint', {
            { 'BufWritePre', '<buffer>', 'EslintFixAll' },
        })
    end
end

--- Calls LSP hover or activates Vim doc (`:h`) depending on filetype.
function M.show_documentation()
    if vim.tbl_contains({ 'vim', 'help', 'lua' }, vim.o.filetype) then
        cmd('h ' .. vim.fn.expand('<cword>'))
    else
        vim.lsp.buf.hover()
    end
end

local function __on_attach(client, bufnr)
    local opts = { buffer = true, bufnr = bufnr }

    require('v.utils.mappings').set_keybindings({
        { 'n', '<leader>gp', '<cmd>lua require("v.utils.lsp").peek_definition()<CR>', opts },
        { 'n', '<leader>s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts },
        { 'n', '<space>rn', '<cmd>lua require("v.utils.lsp").rename()<CR>', opts },
        { 'n', 'K', '<cmd>lua require("v.utils.lsp").show_documentation()<CR>', opts },
        { 'n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts },
        { 'n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts },
        { 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts },
        { 'n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts },
        { 'n', 'gq', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts },

        {
            'n',
            'gl',
            "<cmd>lua vim.diagnostic.open_float(0, { scope = 'line', border = 'single' })<CR>",
            opts,
        },
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

    -- local has_cmp, cmp = pcall(require, 'cmp_nvim_lsp')
    -- if has_cmp then
    --     config = cmp.update_capabilities(config)
    -- end

    config.handlers = {
        ['textDocument/hover'] = lsp.with(lsp.handlers.hover, {
            border = 'single',
        }),

        ['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, {
            border = 'single',
        }),

        ['textDocument/publishDiagnostics'] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
            border = 'single',
            virtual_text = { source = 'always' }, -- or 'if_many'
            severity_sort = true,
            underline = true,
            update_in_insert = false,
        }),

        ['textDocument/formatting'] = M.formatting,
    }

    return config
end

return M
