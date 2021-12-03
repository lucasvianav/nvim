local M = {
    { 'n', '<leader>gp', '<cmd>lua require("v.utils.lsp").peek_definition()<CR>' },
    { 'n', '<space>rn', '<cmd>lua require("v.utils.lsp").rename()<CR>' },
    { 'n', '<space>F', '<cmd>lua vim.lsp.buf.formatting_sync({}, 1000)<CR>' },
    { 'n', 'K', '<cmd>lua require("v.utils.lsp").show_documentation()<CR>' },
    { 'n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>' },
    { 'n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>' },
    { 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>' },
    { 'n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>' },
    { 'n', 'gq', '<cmd>lua vim.diagnostic.setqflist()<CR>' },
    { 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>' },
    { 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>' },
}

return M
