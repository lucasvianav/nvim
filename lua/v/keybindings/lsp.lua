local utils = require("v.utils.lsp")

local __next_diagnost = function()
  vim.diagnostic.jump({ count = 1, float = true })
end

local __prev_diagnost = function()
  vim.diagnostic.jump({ count = -1, float = true })
end

local M = {
  { "n", "<leader>gp", utils.peek_definition },
  { "n", "<leader>rn", utils.rename },
  { "n", "K", utils.show_documentation },
  { "n", "[g", __prev_diagnost },
  { "n", "]g", __next_diagnost },
  { "n", "gD", vim.lsp.buf.declaration },
  { "n", "gh", vim.lsp.buf.hover },
  { "n", "gq", vim.diagnostic.setqflist },
  { "n", "gs", vim.lsp.buf.signature_help },
  { "n", "gl", vim.diagnostic.open_float },
  { "n", "yog", utils.toggle_diagnostics_visibility },
}

return M
