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
--- @param bufnr integer
local function setup_autocmds(client, bufnr)
  local augroup = require("v.utils.autocmds").augroup

  if client.server_capabilities.documentHighlightProvider then
    augroup("LspSymbolHighlight", {
      {
        event = { "CursorHold", "CursorHoldI" },
        opts = { callback = vim.lsp.buf.document_highlight },
      },
      {
        event = {
          "BufLeave",
          "CursorMoved",
          "CursorMovedI",
          "FocusLost",
          "InsertEnter",
          "InsertLeave",
        },
        opts = { callback = vim.lsp.buf.clear_references },
      },
    }, {
      buffer = bufnr,
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
          buffer = bufnr,
        },
      },
    })
  end

  if client.server_capabilities.signatureHelpProvider then
    -- if the plugin is properly loaded it'll take care of it
    if not v.plug.load("lsp_signature") then
      augroup("SignatureHelp", {
        {
          event = "CursorHoldI",
          opts = {
            callback = require("v.lsp").signature_help,
            buffer = bufnr,
          },
        },
      })
    end
  end
end

function M.on_attach(client, bufnr)
  local has_config, config = pcall(require, "v.lsp.servers." .. client.name)

  require("v.utils.mappings").set_keybindings(
    require("v.keybindings.lsp").mappings,
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
