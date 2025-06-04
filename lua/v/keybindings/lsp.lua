local utils = require("v.lsp")

local M = {}

local function goto_reference()
  local ok = v.package_manager == "lazy" or require("v.utils.packer").load_plugin("telescope.nvim")
  if ok then
    require("telescope.builtin").lsp_references()
  else
    vim.lsp.buf.references()
  end
end

M.mappings = {
  { "n", "grp", utils.peek_definition },
  { "n", "grn", utils.rename_symbol },
  { "n", "K",   utils.smart_hover_docs },
  { "n", "gD",  vim.lsp.buf.declaration },
  { "n", "gh",  utils.hover },
  { "n", "gq",  vim.diagnostic.setqflist },
  { "n", "gs",  utils.signature_help },
  { "n", "gl",  vim.diagnostic.open_float },
  { "n", "yog", utils.toggle_diagnostics_visibility },
  { "n", "grr", goto_reference,                     desc = "Goto References" },
  {
    "n",
    "gd",
    function()
      local ok, snacks

      if v.package_manager == "lazy" then
        ok, snacks = pcall(require, "snacks")
      else
        ok, snacks = require("v.utils.packer").load_and_require_plugin("snacks.nvim")
      end

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
      local ok = v.package_manager == "lazy"
          or require("v.utils.packer").load_plugin("telescope.nvim")
      if ok then
        require("telescope.builtin").lsp_implementations()
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
      local ok = v.package_manager == "lazy"
          or require("v.utils.packer").load_plugin("telescope.nvim")
      if ok then
        require("telescope.builtin").diagnostics({ bufnr = 0 })
      end
    end,
    desc = "Diagnostics in Cur Buf",
  },
  {
    "n",
    "<Leader>fgg",
    function()
      local ok = v.package_manager == "lazy"
          or require("v.utils.packer").load_plugin("telescope.nvim")
      if ok then
        require("telescope.builtin").diagnostics({ bufnr = 0 })
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
