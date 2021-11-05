command! Format lua vim.lsp.buf.formatting_sync({}, 1000)
command! FT     lua vim.lsp.buf.formatting_sync({}, 1000)

command! LQF lua vim.diagnostic.setqflist()
