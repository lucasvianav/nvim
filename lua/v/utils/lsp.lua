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

---Max width for floating window stuff, like hover and signature help.
---@see https://github.com/akinsho/dotfiles/blob/d3526289627b72e4b6a3ddcbfe0411b5217a4a88/.config/nvim/plugin/lsp.lua#L145-L158
M.max_float_width = math.max(math.floor(vim.o.columns * 0.7), 100)
---Max height for floating window stuff, like hover and signature help.
M.max_float_height = math.max(math.floor(vim.o.lines * 0.3), 30)

local are_diagnostics_visible = true

---Toggle vim.diagnostics (visibility only).
---@return nil
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
---@return nil
function M.show_documentation()
  if vim.tbl_contains({ 'vim', 'help', 'lua' }, vim.o.filetype) then
    local has_docs = pcall(cmd, 'help ' .. vim.fn.expand('<cword>'))

    if not has_docs then
      vim.lsp.buf.hover()
    end
  else
    vim.lsp.buf.hover()
  end
end

---Function for LSP's 'textDocument/formatting' handler.
---@param err table
---@param result table
---@param ctx table
---@param config table
---@return nil
function M.formatting(err, result, ctx, config)
  if err ~= nil or result == nil then
    return
  end

  local bufnr = ctx.bufnr

  if not api.nvim_buf_get_option(bufnr, 'modified') then
    local view = fn.winsaveview()
    lsp.util.apply_text_edits(result, bufnr, 'utf-16')
    fn.winrestview(view)

    if bufnr == api.nvim_get_current_buf() then
      vim.api.nvim_command('noautocmd :update')
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

---Filters diagnostigs leaving only the most severe per line.
---@param diagnostics table[]
---@return table[]
---@see https://www.reddit.com/r/neovim/comments/mvhfw7/can_built_in_lsp_diagnostics_be_limited_to_show_a/gvd8rb9/
---@see https://github.com/neovim/neovim/issues/15770
---@see https://github.com/akinsho/dotfiles/blob/d3526289627b72e4b6a3ddcbfe0411b5217a4a88/.config/nvim/plugin/lsp.lua#L83-L132
---@see `:h diagnostic-handlers`
M.filter_diagnostics = function(diagnostics)
  if not diagnostics then
    return {}
  end

  -- find the "worst" diagnostic per line
  local most_severe = {}
  for _, cur in pairs(diagnostics) do
    local max = most_severe[cur.lnum]

    -- higher severity has lower value (`:h diagnostic-severity`)
    if not max or cur.severity < max.severity then
      most_severe[cur.lnum] = cur
    end
  end

  -- return list of diagnostics
  return vim.tbl_values(most_severe)
end

-- ____                            _
--|  _ \ ___ _ __   __ _ _ __ ___ (_)_ __   __ _
--| |_) / _ \ '_ \ / _` | '_ ` _ \| | '_ \ / _` |
--|  _ <  __/ | | | (_| | | | | | | | | | | (_| |
--|_| \_\___|_| |_|\__,_|_| |_| |_|_|_| |_|\__, |
--                                         |___/

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
local __rename_callback = function(new, previous)
  if not new then
    return
  end

  local new_name = vim.trim(new)

  if new_name and #new_name > 0 and new_name ~= previous then
    local params = vim.lsp.util.make_position_params()
    params.newName = new_name
    vim.lsp.buf_request(0, 'textDocument/rename', params, __rename_handler)
  end
end

---Rename prompt for symbol below cursor.
function M.rename()
  local curr_word = vim.fn.expand('<cword>')

  require('v.utils.autocmds').augroup('SnacksRename', {
    {
      event = 'FileType',
      opts = {
        pattern = 'snacks_input',
        callback = function()
          vim.api.nvim_feedkeys(curr_word, 'i', false)
          vim.api.nvim_feedkeys(t('<Esc>'), 'n', false)
        end,
        once = true,
      },
    },
  })

  vim.ui.input({ prompt = 'Rename symbol' }, function(input)
    __rename_callback(input, curr_word)
  end)
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

---client.server_capabilities
---@see https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#serverCapabilities

---Disables formatting capabilities for an LSP client.
---@param client table lsp client
local function __disable_formatting(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
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

    __disable_formatting(client)

    local angular_project = vim.fn.filereadable(vim.loop.cwd() .. '/angular.json')
    if not angular_project then
      client.server_capabilities.renameProvider = false
    end

    -- TODO: can I organize imports without ts-utils?
    -- https://github.com/mrjones2014/dotfiles/blob/6159bc2ddfae95af8eed57109b416c37868199a7/.config/nvim/lua/modules/lsp-utils.lua#L57-L73
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

        -- inlay hints
        auto_inlay_hints = false,
        inlay_hints_highlight = 'Comment',
        inlay_hints_priority = 200, -- priority of the hint extmarks
        inlay_hints_throttle = 150, -- throttle the inlay hint request
      })

      ts_utils.setup_client(client)

      -- auto sort imports
      require('v.utils.autocmds').augroup('SortImportsTS', {
        { event = 'BufWritePre', opts = { command = 'TSLspOrganizeSync', buffer = 0 } },
      })

      buf_set_keymap('n', '<leader>si', '<cmd>TSLspOrganize<CR>')
    end
    -- buf_set_keymap('n', '<leader>si', '<cmd>lua typescript_sort_imports(' .. bufnr .. ')<CR>')
  end,

  pyright = function(client, bufnr)
    local function buf_set_keymap(...)
      local args = { ... }
      api.nvim_buf_set_keymap(bufnr, args[1], args[2], args[3], {
        noremap = true,
        silent = true,
      })
    end

    __disable_formatting(client)
    buf_set_keymap('n', '<leader>si', '<cmd>PyrightOrganizeImports<CR>')
  end,

  efm = function(client)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true
    client.server_capabilities.hoverProvider = false
    client.server_capabilities.renameProvider = false
  end,

  sqls = function(client)
    local ok, sqls = pcall(require, 'sqls')
    if ok then
      client.commands = sqls.commands
      sqls.setup({ picker = 'telescope' })
    end

    __disable_formatting(client)
  end,

  angularls = __disable_formatting,
  cssls = __disable_formatting,
  eslint = __disable_formatting,
  graphql = __disable_formatting,
  html = __disable_formatting,
  jedi_language_server = __disable_formatting,
  jsonls = __disable_formatting,
  pylsp = __disable_formatting,
  lua_ls = __disable_formatting,
  vimls = __disable_formatting,
}

--- Setup autcommands based on LSP client's characteristics.
--- @param client table lsp client
local function __conditional_autocmds(client)
  local augroup = require('v.utils.autocmds').augroup

  if client.server_capabilities.documentHighlightProvider then
    augroup('LspSymbolHighlight', {
      -- highlight
      { event = 'CursorHold',   opts = { callback = vim.lsp.buf.document_highlight } },
      { event = 'CursorHoldI',  opts = { callback = vim.lsp.buf.document_highlight } },

      -- clear
      { event = 'CursorMoved',  opts = { callback = vim.lsp.buf.clear_references } },
      { event = 'CursorMovedI', opts = { callback = vim.lsp.buf.clear_references } },
      { event = 'FocusLost',    opts = { callback = vim.lsp.buf.clear_references } },
      { event = 'BufLeave',     opts = { callback = vim.lsp.buf.clear_references } },
      { event = 'InsertEnter',  opts = { callback = vim.lsp.buf.clear_references } },
    }, {
      buffer = 0,
    })
  end

  if client.server_capabilities.documentFormattingProvider then
    augroup('AutoFormat', {
      {
        event = 'BufWritePost',
        opts = {
          callback = function()
            vim.lsp.buf.format({ async = true })
          end,
          buffer = 0,
        },
      },
    })
  end

  local signature_ok = pcall(require, 'lsp_signature')
  if client.server_capabilities.signatureHelpProvider and not signature_ok then
    augroup('SignatureHelp', {
      { event = 'CursorHoldI', opts = { callback = vim.lsp.buf.signature_help, buffer = 0 } },
    })
  end

  if client.name == 'eslint' then
    augroup('AutoFormatEslint', {
      { event = 'BufWritePre', opts = { command = 'EslintFixAll', buffer = 0 } },
    })
  end
end

-- TODO: https://github.com/hrsh7th/nvim-cmp/issues/465#issuecomment-981159946
local function __on_attach(client, bufnr)
  local keybindings = require('v.keybindings.lsp')

  if client.name == 'clangd' then
    table.insert(keybindings, { 'n', 'gpp', '<cmd>ClangdSwitchSourceHeader<cr>' })
  elseif client.name == 'angularls' then
    local fun = function(ext)
      return '<cmd>lua require("v.utils").open_file_swap_extension("' .. ext .. '")<cr>'
    end

    table.insert(keybindings, { 'n', 'gpt', fun('ts') })
    table.insert(keybindings, { 'n', 'gph', fun('html') })
    table.insert(keybindings, { 'n', 'gps', fun('scss') })
  end

  -- formatting keybinding
  table.insert(keybindings, {
    'n',
    '<space>F',
    function()
      vim.lsp.buf.format({ async = true })
    end,
  })

  require('v.utils.mappings').set_keybindings(keybindings, { buffer = bufnr })

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

  local has_cmp, cmp = pcall(require, 'cmp_nvim_lsp')
  if has_cmp then
    capabilities = cmp.default_capabilities()
  end

  config = vim.tbl_deep_extend('keep', config or {}, {
    capabilities = capabilities,
    on_attach = __on_attach,
    flags = {
      debounce_text_changes = 200,
    },
  })

  return config
end

return M
