local lsp = vim.lsp
local fn = vim.fn
local api = vim.api
local cmd = vim.api.nvim_command

local M = {}

M.servers = require('v.settings.lsp').servers

--  ____                           _     _   _ _   _ _
-- / ___| ___ _ __   ___ _ __ __ _| |   | | | | |_(_) |___
--| |  _ / _ \ '_ \ / _ \ '__/ _` | |   | | | | __| | / __|
--| |_| |  __/ | | |  __/ | | (_| | |   | |_| | |_| | \__ \
--\____|\___|_| |_|\___|_|  \__,_|_|    \___/ \__|_|_|___/

local are_diagnostics_visible = true
---Toggle vim.diagnostics (visibility only).
M.toggle_diagnostics_visibility = function()
    if are_diagnostics_visible then
        vim.diagnostic.hide()
        are_diagnostics_visible = false
    else
        vim.diagnostic.show()
        are_diagnostics_visible = true
    end
end

---Calls LSP hover or activates Vim doc (`:h`) depending on filetype.
function M.show_documentation()
    if vim.tbl_contains({ 'vim', 'help', 'lua' }, vim.o.filetype) then
        cmd('h ' .. vim.fn.expand('<cword>'))
    else
        vim.lsp.buf.hover()
    end
end

---Function for LSP's 'textDocument/formatting' handler.
---@param err table
---@param result table
---@param ctx table
---@param config table
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

-- ____                            _
--|  _ \ ___ _ __   __ _ _ __ ___ (_)_ __   __ _
--| |_) / _ \ '_ \ / _` | '_ ` _ \| | '_ \ / _` |
--|  _ <  __/ | | | (_| | | | | | | | | | | (_| |
--|_| \_\___|_| |_|\__,_|_| |_| |_|_|_| |_|\__, |
--                                         |___/

local __rename_prompt = 'Rename   '

---Function for LSP's 'textDocument/rename' handler.
---@param err table
---@param result table
---@param ctx table
---@param config table
local function __rename_handler(err, result, ctx, config)
    if err then
        vim.api.nvim_notify(
            ("Error running LSP query '%s': %s"):format(ctx.method, err),
            vim.log.levels.ERROR,
            { title = 'LSP --- Renaming' }
        )
        return
    end

    -- notify the files in which the change happened
    if result and result.documentChanges and #result.documentChanges > 1 then
        local new_word = ctx.params.newName
        local no_files = #result.documentChanges
        local msg = ('The symbol was renamed in %d files:\n'):format(no_files)

        for _, change in ipairs(result.documentChanges) do
            local get_path = require('v.utils').get_relative_path
            msg = msg .. (' - %s\n'):format(get_path(change.textDocument.uri))
        end

        local curr_name = vim.fn.expand('<cword>')
        msg = msg:sub(1, #msg - 1)
        vim.notify(
            msg,
            vim.log.levels.INFO,
            { title = ('LSP Rename: %s =>> %s'):format(curr_name, new_word) }
        )
    end

    vim.lsp.handlers[ctx.method](err, result, ctx, config)
end

---Confirms/declines the renaming.
function M.rename_callback()
    local new_name = vim.trim(vim.fn.getline('.'):sub(#__rename_prompt + 1, -1))
    vim.api.nvim_command([[stopinsert]])
    vim.api.nvim_command([[bd!]])

    if new_name and #new_name > 0 and new_name ~= vim.fn.expand('<cword>') then
        local params = vim.lsp.util.make_position_params()
        params.newName = new_name
        vim.lsp.buf_request(0, 'textDocument/rename', params, __rename_handler)
    end
end

-- TODO: https://github.com/filipdutescu/renamer.nvim
-- TODO: https://github.com/neovim/neovim/commit/16d4af6d2f549709aa55510f5ae52238c5cadb9c
-- TODO: https://www.reddit.com/r/neovim/comments/r0omlv/start_your_search_from_a_more_comfortable_place/
---Custom rename prompt for symbol below cursor.
function M.rename()
    local current_name = vim.fn.expand('<cword>')
    local bufnr = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_option(bufnr, 'buftype', 'prompt')
    vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'wipe')
    vim.api.nvim_buf_add_highlight(bufnr, -1, 'RenamePrompt', 0, 0, #__rename_prompt)
    vim.fn.prompt_setprompt(bufnr, __rename_prompt)

    local win_opts = {
        relative = 'cursor',
        width = 55,
        height = 1,
        row = -3,
        col = 1,
        style = 'minimal',
        border = 'single',
    }
    local winnr = vim.api.nvim_open_win(bufnr, true, win_opts)

    --[[ TODO: add border with title using plenary
        -- checkout plenary.popup
        -- https://github.com/filipdutescu/renamer.nvim/blob/37c27fa77571ba9a81d06e148500fad9638bbe42/lua/renamer/init.lua
        -- https://github.com/nvim-lua/popup.nvim/blob/master/lua/popup/init.lua

        vim.api.nvim_set_current_win(border.win_id)
        local border = require('plenary.window.border'):new(bufnr, winnr, win_opts, {
            top = '─',
            right = '│',
            bot = '─',
            left = '│',
            topright = '╮',
            botleft = '╰',
            topleft = '╭',
            botright = '╯',
            title = 'Rename',
        })
        P(border, border.win_id)

        vim.api.nvim_win_set_option(border.win_id, 'winhl', 'Normal:Floating')
        vim.api.nvim_win_set_option(border.win_id, 'cursorline', false)
        vim.api.nvim_win_set_option(border.win_id, 'scrolloff', 0)
    ]]

    vim.api.nvim_win_set_option(winnr, 'winhl', 'Normal:Floating')
    vim.api.nvim_win_set_option(winnr, 'cursorline', false)
    vim.api.nvim_win_set_option(winnr, 'scrolloff', 0)

    require('v.utils.mappings').set_keybindings({
        { 'n', '<ESC>', '<cmd>bd!<CR>' },
        { 'n', '<C-C>', '<cmd>bd!<CR>' },
        { 'n', 'q', '<cmd>bd!<CR>' },
        { 'i', '<ESC>', '<Esc><cmd>bd!<CR>' },
        { 'i', '<C-C>', '<Esc><cmd>bd!<CR>' },
        { 'i', '<BS>', '<ESC>"_xi' }, -- TODO: make this better https://gist.github.com/VonHeikemen/a0a58cab2c910065420ecf5f4102c58c
        { { 'n', 'i' }, '<CR>', "<cmd>lua require('v.utils.lsp').rename_callback()<CR>" },
    }, {
        buffer = true,
    })

    cmd('normal i' .. current_name)
end

-- ____           _      ____        __ _       _ _   _
--|  _ \ ___  ___| | __ |  _ \  ___ / _(_)_ __ (_) |_(_) ___  _ __
--| |_) / _ \/ _ \ |/ / | | | |/ _ \ |_| | '_ \| | __| |/ _ \| '_ \
--|  __/  __/  __/   <  | |_| |  __/  _| | | | | | |_| | (_) | | | |
--|_|   \___|\___|_|\_\ |____/ \___|_| |_|_| |_|_|\__|_|\___/|_| |_|

local function __peek_definitin_callback(_, result)
    if result == nil or vim.tbl_isempty(result) then
        return nil
    end

    lsp.util.preview_location(result[1])
end

-- TODO: https://www.reddit.com/r/neovim/comments/qpfc25/telescope_preview_definition/
---Peek definition for symbl below the cursor. Similar to VSCode's Peek
---Definition.
function M.peek_definition()
    return vim.lsp.buf_request(
        0,
        'textDocument/definition',
        lsp.util.make_position_params(),
        __peek_definitin_callback
    )
end

--    _        _               _   _     ____  ____
--   / \   ___| |_ _   _  __ _| | | |   / ___||  _ \
--  / _ \ / __| __| | | |/ _` | | | |   \___ \| |_) |
-- / ___ \ (__| |_| |_| | (_| | | | |___ ___) |  __/
--/_/   \_\___|\__|\__,_|\__,_|_| |_____|____/|_|
--
-- ____       _   _   _
--/ ___|  ___| |_| |_(_)_ __   __ _ ___
--\___ \ / _ \ __| __| | '_ \ / _` / __|
-- ___) |  __/ |_| |_| | | | | (_| \__ \
--|____/ \___|\__|\__|_|_| |_|\__, |___/
--                            |___/

---Disables formatting capabilities for an LSP client.
---@param client table lsp client
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

    efm = function(client)
        client.resolved_capabilities.document_formatting = true
        client.resolved_capabilities.document_range_formatting = true
        client.resolved_capabilities.hover = false
        client.resolved_capabilities.rename = false
    end,

    sqls = function(client)
        local ok, sqls = pcall(require, 'sqls')
        if ok then
            client.resolved_capabilities.execute_command = true
            client.commands = sqls.commands
            sqls.setup({ picker = 'telescope' })
        end

        disable_formatting(client)
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

    local signature_ok = pcall(require, 'lsp_signature')
    if client.resolved_capabilities.signature_help and not signature_ok then
        augroup('SignatureHelp', {
            { 'CursorHoldI', '<buffer>', 'silent! lua vim.lsp.buf.signature_help()' },
        })
    end

    if client.name == 'eslint' then
        augroup('AutoFormatEslint', {
            { 'BufWritePre', '<buffer>', 'EslintFixAll' },
        })
    end
end

local __keybindings = require('v.keybindings.lsp')

-- TODO: https://github.com/hrsh7th/nvim-cmp/issues/465#issuecomment-981159946
local function __on_attach(client, bufnr)
    require('v.utils.mappings').set_keybindings(__keybindings, {
        buffer = true,
        bufnr = bufnr,
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

    local has_coq, coq = pcall(require, 'coq')
    if has_coq then
        capabilities = coq.lsp_ensure_capabilities(capabilities)
    end

    local has_cmp, cmp = pcall(require, 'cmp_nvim_lsp')
    if has_cmp then
        capabilities = cmp.update_capabilities(capabilities)
    end

    config = vim.tbl_deep_extend('keep', config or {}, {
        capabilities = capabilities,
        on_attach = __on_attach,
    })

    config.handlers = {
        ['textDocument/hover'] = lsp.with(lsp.handlers.hover, {
            border = 'single',
        }),

        ['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, {
            border = 'single',
        }),

        ['textDocument/publishDiagnostics'] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
            border = 'single',
        }),

        ['textDocument/formatting'] = M.formatting,
    }

    return config
end

return M
