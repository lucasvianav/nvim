local lsp = vim.lsp
local utils = require("v.utils.lsp")

lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, {
  border = "rounded",
  max_width = utils.max_float_width,
  max_height = utils.max_float_height,
})

lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, {
  border = "rounded",
  max_width = utils.max_float_width,
  max_height = utils.max_float_height,
})

lsp.handlers["textDocument/formatting"] = utils.formatting

-- ____ ___ ____ _   _     ____ ___  _    _   _ __  __ _   _
--/ ___|_ _/ ___| \ | |   / ___/ _ \| |  | | | |  \/  | \ | |
--\___ \| | |  _|  \| |  | |  | | | | |  | | | | |\/| |  \| |
-- ___) | | |_| | |\  |  | |__| |_| | |__| |_| | |  | | |\  |
--|____/___\____|_| \_|   \____\___/|_____\___/|_|  |_|_| \_|

---custom namespace
local ns = vim.api.nvim_create_namespace("severe-diagnostics")

---reference to the original handler
local orig_signs_handler = vim.diagnostic.handlers.signs

---Overriden diagnostics signs helper to only show the single most relevant sign
---@see `:h diagnostic-handlers`
vim.diagnostic.handlers.signs = {
  show = function(_, bufnr, _, opts)
    -- get all diagnostics from the whole buffer rather
    -- than just the diagnostics passed to the handler
    local diagnostics = vim.diagnostic.get(bufnr)

    local filtered_diagnostics = utils.filter_diagnostics(diagnostics)

    -- pass the filtered diagnostics (with the
    -- custom namespace) to the original handler
    orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
  end,

  hide = function(_, bufnr)
    orig_signs_handler.hide(ns, bufnr)
  end,
}
