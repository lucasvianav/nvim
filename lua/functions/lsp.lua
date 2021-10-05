local lsp = vim.lsp
local fn = vim.fn
local api = vim.api
local cmd = vim.cmd
local util = lsp.util

--[[
Built-in LSP's GoToDefinition handler that supports splitting.
]]
function _G.lsp_goto_definition(split_cmd)
    local log = require('vim.lsp.log')

    -- (_, result, {method=method})
    local handler = function(_, method, result)
        if result == nil or vim.tbl_isempty(result) then
            local _ = log.info() and log.info(method, 'No location found')
            return nil
        end

        if split_cmd then
            if contains(split_cmd, { 'split', 'vsplit' }) then
                cmd(split_cmd)
            else
                cmd('vsplit')
            end
        end

        if vim.tbl_islist(result) then
            util.jump_to_location(result[1])

            if #result > 1 then
                util.set_qflist(util.locations_to_items(result))
                api.nvim_command('copen')
                api.nvim_command('wincmd p')
            end
        else
            util.jump_to_location(result)
        end
    end

    return handler
end

local function peek_definitin_callback(_, result)
    if result == nil or vim.tbl_isempty(result) then
        return nil
    end

    lsp.util.preview_location(result[1])
end

--[[
Analogue to VSCode's PeekDefiniton.
]]
function _G.lsp_peek_definition()
    return vim.lsp.buf_request(
        0,
        'textDocument/definition',
        lsp.util.make_position_params(),
        peek_definitin_callback
    )
end

local orig_set_signs = vim.lsp.diagnostic.set_signs

--[[
Get most severe diagnostic sign per line.
]]
function _G.lsp_set_signs_limited(diagnostics, bufnr, client_id, sign_ns, opts)
    -- original func runs some checks, which I
    -- think is worth doing but maybe overkill
    if not diagnostics then
        diagnostics = diagnostic_cache[bufnr][client_id]
    end

    -- early escape
    if not diagnostics then
        return
    end

    -- work out max severity diagnostic per line
    local max_severity_per_line = {}
    for _, d in pairs(diagnostics) do
        if max_severity_per_line[d.range.start.line] then
            local current_d = max_severity_per_line[d.range.start.line]

            if d.severity < current_d.severity then
                max_severity_per_line[d.range.start.line] = d
            end
        else
            max_severity_per_line[d.range.start.line] = d
        end
    end

    -- map to list
    local filtered_diagnostics = {}
    for i, v in pairs(max_severity_per_line) do
        table.insert(filtered_diagnostics, v)
    end

    -- call original func
    orig_set_signs(filtered_diagnostics, bufnr, client_id, sign_ns, opts)
end

--[[
LSP's 'textDocument/formatting' handler.
]]
-- TODO: https://github.com/lukas-reineke/dotfiles/blob/5b84e9264d3ca9e40fd773642e5a1d335224733e/vim/lua/lsp/formatting.lua#L38-L43
-- TODO: https://github.com/lukas-reineke/dotfiles/blob/5b84e9264d3ca9e40fd773642e5a1d335224733e/vim/lua/lsp/handlers.lua#L1-L15
function _G.lsp_formatting_handler(err, _, result, _, bufnr)
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
            vim.notify('Formatted: ' .. bufnr, 'info', { title = 'LSP' })
        end
    end
end

local function disable_formatting(client)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
end

local specific_on_attach = {
    typescript = function(client, bufnr)
        local function buf_set_keymap(...)
            local args = { ... }
            api.nvim_buf_set_keymap(bufnr, args[1], args[2], args[3], {
                noremap = true,
                silent = true,
            })
        end

        disable_formatting(client)

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
    end,

    angular = disable_formatting,
    css = disable_formatting,
    graphql = disable_formatting,
    json = disable_formatting,
    html = disable_formatting,
    lua = disable_formatting,
    python = disable_formatting,
    vim = disable_formatting,
}

local function conditional_autocmds(client)
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
        -- au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
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
end

local function on_attach(client, bufnr)
    local function buf_set_keymap(...)
        local args = { ... }
        api.nvim_buf_set_keymap(bufnr, args[1], args[2], args[3], {
            noremap = true,
            silent = true,
        })
    end

    -- enable completion triggered by <c-x><c-o>
    api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- mappings
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>')
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
    buf_set_keymap('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
    buf_set_keymap('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')

    -- TODO: also show help
    -- https://github.com/lucasvianav/nvim/blob/21062452bc1f7db702cc9a0d537cbad4b2aa683b/general/plugins/config/coc.vim#L79-L87
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')

    -- buf_set_keymap('n', 'gd',        '<cmd>lua vim.lsp.buf.definition()<CR>')
    -- buf_set_keymap('n', '<space>D',  '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    -- buf_set_keymap('n', '<C-k>',     '<cmd>lua vim.lsp.buf.signature_help()<CR>',               opts)
    -- buf_set_keymap('n', '<space>e',  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    -- buf_set_keymap('n', '<space>q',  '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',           opts)
    -- buf_set_keymap('n', '<space>f',  '<cmd>lua vim.lsp.buf.formatting()<CR>',                   opts)

    if specific_on_attach[client.name] then
        specific_on_attach[client.name](client, bufnr)
    end

    conditional_autocmds(client)
end

--[[
Returns a config for a LSP client to activate keybindings and enables snippet support, as well as include autocompletion plugin stuff.
]]
function _G.lsp_make_config(config)
    local capabilities = lsp.protocol.make_client_capabilities()

    -- enable snippets
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- TODO: https://github.com/JoosepAlviste/dotfiles/blob/b09a4eed7bf4c7862a02aa8b14ffe29896a0bfa5/config/nvim/lua/j/plugins/lsp/init.lua#L115-L132
    -- not too sure
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
        on_attach = on_attach,
    })

    local has_coq, coq = pcall(require, 'coq')
    if has_coq then
        config = coq.lsp_ensure_capabilities(config)
    end

    return config
end
