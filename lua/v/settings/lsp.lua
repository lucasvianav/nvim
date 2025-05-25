vim.diagnostic.config({
  severity_sort = true,
  underline = true,
  update_in_insert = false,
  signs = true,
  float = {
    scope = "line",
    border = "rounded",
    source = true,
    focusable = true,
    close_events = {
      "BufLeave",
      "CursorMoved",
      "InsertEnter",
      "FocusLost",
    },
  },
  virtual_text = {
    source = true,
  },
})
vim.lsp.set_log_level("INFO")

local utils = require("v.utils.lsp")
vim.diagnostic.handlers.signs = utils.diagnostic_signs_handler
vim.lsp.handlers["textDocument/formatting"] = utils.handle_formatting
