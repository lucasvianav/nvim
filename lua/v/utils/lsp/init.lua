local M = {}

local on_attach = require("v.utils.lsp.on_attach").on_attach
local diagnostics = require("v.utils.lsp.diagnostics")
local hover = require("v.utils.lsp.hover")

---Generate a language server config to be passed into [vim.lsp.config]
---@param config? table
---@return table
function M.make_config(config)
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  require("v.utils.packer").load_plugin("cmp-nvim-lsp")
  local has_cmp, cmp = pcall(require, "cmp_nvim_lsp")
  if has_cmp then
    capabilities = cmp.default_capabilities()
  end

  return vim.tbl_deep_extend("keep", config or {}, {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 200,
    },
  })
end

M.rename_symbol = require("v.utils.lsp.renaming").rename_symbol
M.handle_formatting = require("v.utils.lsp.formatting").handler
M.smart_hover_docs = hover.smart_docs
M.peek_definition = hover.peek_definition
M.hover = hover.hover
M.signature_help = hover.signature_help
M.toggle_diagnostics_visibility = diagnostics.toggle_visibility
M.diagnostic_signs_handler = diagnostics.signs_handler

return M
