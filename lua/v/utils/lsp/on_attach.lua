-- TODO: https://github.com/hrsh7th/nvim-cmp/issues/465#issuecomment-981159946

local M = {}

---Disable formatting capabilities for a client
---@param client table lsp client
function M.disable_formatting(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

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
end

function M.on_attach(client, bufnr)
  local lsp_keyb = require("v.keybindings.lsp")
  local has_config, config = pcall(require, "v.plugins.lsp.servers." .. client.name)

  require("v.utils.mappings").set_keybindings(
    table.merge_lists(lsp_keyb.general, lsp_keyb[client.name] or {}),
    { buffer = bufnr }
  )

  -- enable completion triggered by <c-x><c-o>
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

  if has_config and config and config.on_attach then
    config.on_attach(client, bufnr)
  end

  setup_autocmds(client)
end

return M
