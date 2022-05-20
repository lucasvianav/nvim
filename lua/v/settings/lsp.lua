local M = {}

---Language servers to keep installed
M.servers = {
  'angularls',
  'bashls',
  'clangd',
  'cssls',
  'cssmodules_ls',
  'dockerls',
  'efm',
  'emmet_ls',
  'graphql',
  'html',
  'jsonls',
  'pylsp',
  'pyright',
  'sqlls',
  'sqls',
  'sumneko_lua',
  'tsserver',
  'vimls',
}

---General diagnostics settings
vim.diagnostic.config({
  severity_sort = true,
  underline = true,
  update_in_insert = false,
  signs = true,
  float = {
    scope = 'line',
    border = 'single',
    source = 'always',
    focusable = false,
    close_events = {
      'BufLeave',
      'CursorMoved',
      'InsertEnter',
      'FocusLost',
    },
  },
  virtual_text = {
    source = 'always',
  },
})

return M
