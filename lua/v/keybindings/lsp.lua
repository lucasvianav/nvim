local utils = require("v.lsp")

local M = {}

M.mappings = {
  { "n", "grp", utils.peek_definition },
  { "n", "grn", utils.rename_symbol },
  { "n", "K",   utils.smart_hover_docs },
  { "n", "gh",  utils.hover },
  { "n", "gq",  vim.diagnostic.setqflist },
  { "n", "gs",  utils.signature_help },
  { "n", "gl",  vim.diagnostic.open_float },
  { "n", "yog", utils.toggle_diagnostics_visibility },
  {
    "n",
    "grr",
    function()
      local ok, builtin = pcall(require, "telescope.builtin")
      if ok then
        builtin.lsp_references()
      else
        vim.lsp.buf.references()
      end
    end,
    desc = "Goto References"
  },
  {
    "n",
    "gD",
    function()
      local ok, snacks = pcall(require, "snacks")
      if ok then
        snacks.picker.lsp_declarations({ unique_lines = true })
      else
        vim.lsp.buf.declaration()
      end
    end,
  },
  {
    "n",
    "gd",
    function()
      local ok, snacks = pcall(require, "snacks")
      if ok then
        snacks.picker.lsp_definitions({ unique_lines = true })
      else
        vim.lsp.buf.definition()
      end
    end,
    desc = "Goto Definition",
  },
  {
    "n",
    "gi",
    function()
      local ok, builtin = pcall(require, "telescope.builtin")
      if ok then
        builtin.lsp_implementations()
      else
        vim.lsp.buf.implementation()
      end
    end,
    desc = "Goto Implementation",
  },
  {
    "n",
    "<Leader>fg",
    function()
      local ok, builtin = pcall(require, "telescope.builtin")
      if ok then
        builtin.diagnostics({ bufnr = 0 })
      end
    end,
    desc = "Diagnostics in Cur Buf",
  },
  {
    "n",
    "<Leader>fgg",
    function()
      local ok, builtin = pcall(require, "telescope.builtin")
      if ok then
        builtin.diagnostics()
      end
    end,
    desc = "Diagnostics Workspace",
  },
  {
    { "n", "v" },
    "gra",
    vim.lsp.buf.code_action,
    desc = "Code Actions",
  },
  {
    "n",
    "[g",
    function()
      vim.diagnostic.jump({ count = -1, float = true })
    end,
  },
  {
    "n",
    "]g",
    function()
      vim.diagnostic.jump({ count = 1, float = true })
    end,
  },
  {
    "n",
    "<leader>F",
    function()
      vim.lsp.buf.format({ async = true })
    end,
  },
}

return M
