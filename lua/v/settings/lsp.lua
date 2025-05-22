local M = {}

M.formatters = {
  "eslint_d",
  "prettier",
  "prettierd",
  "markdownlint",
  "black",
  "blackd-client",
  "flake8",
  "mypy",
  "vint",
  "stylua",
}

M.servers = {
  "bashls",
  "clangd",
  "cssls",
  "cssmodules_ls",
  "dockerls",
  "efm",
  "emmet_ls",
  "graphql",
  "html",
  "jsonls",
  "lua_ls",
  "protols",
  "pylsp",
  "pyright",
  "sqlls",
  "sqls",
  "ts_ls",
  "vimls",
  "yamlls",
}

---General diagnostics settings
vim.diagnostic.config({
  severity_sort = true,
  underline = true,
  update_in_insert = false,
  signs = true,
  float = {
    scope = "line",
    border = "single",
    source = "always",
    focusable = false,
    close_events = {
      "BufLeave",
      "CursorMoved",
      "InsertEnter",
      "FocusLost",
    },
  },
  virtual_text = {
    source = "always",
  },
})

vim.lsp.set_log_level("debug")

return M
