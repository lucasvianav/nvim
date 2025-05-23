-- TODO: https://github.com/hrsh7th/nvim-cmp/issues/465#issuecomment-981159946

---TODO create type
---client.server_capabilities
---@see https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#serverCapabilities

local M = {}
local api = vim.api

---Disable formatting capabilities for a client
---@param client table lsp client
local function disable_formatting(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

local function typescript_sort_imports(bufnr, post)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local METHOD = "workspace/executeCommand"
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(bufnr) },
    title = "",
  }

  local callback = function(err)
    if not err and post then
      post()
    end
  end

  vim.lsp.buf_request(bufnr, METHOD, params, callback)
end

---@type table<lsp_servers, function>
local specific_on_attach = {
  ts_ls = function(client, bufnr)
    local function buf_set_keymap(...)
      local args = { ... }
      api.nvim_buf_set_keymap(bufnr, args[1], args[2], args[3], {
        noremap = true,
        silent = true,
      })
    end

    disable_formatting(client)

    local angular_project = vim.fn.filereadable(vim.loop.cwd() .. "/angular.json")
    if not angular_project then
      client.server_capabilities.renameProvider = false
    end

    -- TODO: can I organize imports without ts-utils?
    -- https://github.com/mrjones2014/dotfiles/blob/6159bc2ddfae95af8eed57109b416c37868199a7/.config/nvim/lua/modules/lsp-utils.lua#L57-L73
    local has_ts_utils, ts_utils =
      require("v.utils.packer").load_and_require_plugin("nvim-lsp-ts-utils")

    if has_ts_utils then
      ts_utils.setup({
        enable_import_on_completion = true,
        import_all_scan_buffers = 100,

        -- eslint
        eslint_enable_code_actions = true,
        eslint_enable_disable_comments = true,
        eslint_bin = "eslint_d",
        eslint_enable_diagnostics = true,

        -- formatting
        formatter = "eslint_d",
        -- formatter = 'prettier',
        formatter_opts = {},

        -- update imports on file move
        update_imports_on_move = false,

        -- inlay hints
        auto_inlay_hints = false,
        inlay_hints_highlight = "Comment",
        inlay_hints_priority = 200, -- priority of the hint extmarks
        inlay_hints_throttle = 150, -- throttle the inlay hint request
      })

      ts_utils.setup_client(client)

      -- auto sort imports
      require("v.utils.autocmds").augroup("SortImportsTS", {
        { event = "BufWritePre", opts = { command = "TSLspOrganizeSync", buffer = 0 } },
      })

      buf_set_keymap("n", "<leader>si", "<cmd>TSLspOrganize<CR>")
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

    disable_formatting(client)
    buf_set_keymap("n", "<leader>si", "<cmd>PyrightOrganizeImports<CR>")
  end,

  efm = function(client)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true
    client.server_capabilities.hoverProvider = false
    client.server_capabilities.renameProvider = false
  end,

  sqls = function(client)
    local ok, sqls = require("v.utils.packer").load_and_require_plugin("sqls")

    if ok then
      client.commands = sqls.commands
      sqls.setup({ picker = "telescope" })
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
  kotlin_bazel_lsp = disable_formatting,
  lua_ls = disable_formatting,
  pylsp = disable_formatting,
  vimls = disable_formatting,
}

--- Setup autcommands based on the LSP capabilitier
--- @param client table lsp client
local function setup_autocmds(client)
  local augroup = require("v.utils.autocmds").augroup

  if client.server_capabilities.documentHighlightProvider then
    augroup("LspSymbolHighlight", {
      -- highlight
      { event = "CursorHold", opts = { callback = vim.lsp.buf.document_highlight } },
      { event = "CursorHoldI", opts = { callback = vim.lsp.buf.document_highlight } },

      -- clear
      { event = "CursorMoved", opts = { callback = vim.lsp.buf.clear_references } },
      { event = "CursorMovedI", opts = { callback = vim.lsp.buf.clear_references } },
      { event = "FocusLost", opts = { callback = vim.lsp.buf.clear_references } },
      { event = "BufLeave", opts = { callback = vim.lsp.buf.clear_references } },
      { event = "InsertEnter", opts = { callback = vim.lsp.buf.clear_references } },
    }, {
      buffer = 0,
    })
  end

  if client.server_capabilities.documentFormattingProvider then
    augroup("AutoFormat", {
      {
        event = "BufWritePost",
        opts = {
          callback = function()
            vim.lsp.buf.format({ async = true })
          end,
          buffer = 0,
        },
      },
    })
  end

  local signature_ok = require("v.utils.packer").load_and_require_plugin("lsp_signature")
  if client.server_capabilities.signatureHelpProvider and signature_ok then
    augroup("SignatureHelp", {
      {
        event = "CursorHoldI",
        opts = { callback = vim.lsp.buf.signature_help, buffer = 0 },
      },
    })
  end

  if client.name == "eslint" then
    augroup("AutoFormatEslint", {
      { event = "BufWritePre", opts = { command = "EslintFixAll", buffer = 0 } },
    })
  end
end

function M.on_attach(client, bufnr)
  local lsp_keybindings = require("v.keybindings.lsp")
  local keybindings = lsp_keybindings.general

  if lsp_keybindings[client.name] then
    keybindings =
      require("v.utils.tables").merge_lists({ keybindings, lsp_keybindings[client.name] })
  end

  require("v.utils.mappings").set_keybindings(keybindings, { buffer = bufnr })

  -- enable completion triggered by <c-x><c-o>
  api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

  if specific_on_attach[client.name] then
    specific_on_attach[client.name](client, bufnr)
  end

  setup_autocmds(client)
end

return M
