local lsp = vim.lsp
local utils = require("v.utils.lsp")

---Max width for floating window stuff, like hover and signature help.
---@see https://github.com/akinsho/dotfiles/blob/d3526289627b72e4b6a3ddcbfe0411b5217a4a88/.config/nvim/plugin/lsp.lua#L145-L158
local max_float_width = math.max(math.floor(vim.o.columns * 0.7), 100)
---Max height for floating window stuff, like hover and signature help.
local max_float_height = math.max(math.floor(vim.o.lines * 0.3), 30)

lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, {
  border = "rounded",
  max_width = max_float_width,
  max_height = max_float_height,
})

lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, {
  border = "rounded",
  max_width = max_float_width,
  max_height = max_float_height,
})

lsp.handlers["textDocument/formatting"] = utils.handle_formatting

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
