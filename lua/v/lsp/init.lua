local M = {}

local on_attach = require("v.lsp.on_attach").on_attach
local diagnostics = require("v.lsp.diagnostics")
local hover = require("v.lsp.hover")

---Generate a language server config to be passed into [vim.lsp.config]
---@param config? table
---@return table
function M.make_config(config)
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  if v.package_manager == "packer" then
    require("v.utils.packer").load_plugin("cmp-nvim-lsp")
  end
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

M.rename_symbol = require("v.lsp.renaming").rename_symbol
M.handle_formatting = require("v.lsp.formatting").handler
M.smart_hover_docs = hover.smart_docs
M.peek_definition = hover.peek_definition
M.hover = hover.hover
M.signature_help = hover.signature_help
M.toggle_diagnostics_visibility = diagnostics.toggle_visibility
M.diagnostic_signs_handler = diagnostics.signs_handler

return M
