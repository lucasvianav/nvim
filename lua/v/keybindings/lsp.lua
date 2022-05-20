local utils = require('v.utils.lsp')

local M = {
  { 'n', '<leader>gp', utils.peek_definition },
  { 'n', '<leader>rn', utils.rename },
  { 'n', 'K', utils.show_documentation },
  { 'n', '[g', vim.diagnostic.goto_prev },
  { 'n', ']g', vim.diagnostic.goto_next },
  { 'n', 'gD', vim.lsp.buf.declaration },
  { 'n', 'gh', vim.lsp.buf.hover },
  { 'n', 'gq', vim.diagnostic.setqflist },
  { 'n', 'gs', vim.lsp.buf.signature_help },
  { 'n', 'gl', vim.diagnostic.open_float },
  { 'n', 'yog', utils.toggle_diagnostics_visibility },
}

return M
