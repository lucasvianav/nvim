local M = {}

M.config = {
  settings = {
    python = {
      analysis = {
        extraPaths = { ".", "./*", "./**/*", "./**/**/*" },
        useImportHeuristic = true,
      },
    },
  },
}

function M.on_attach(client, bufnr)
  require("v.lsp.on_attach").disable_formatting(client)
  require("v.utils.mappings").map({
    "n",
    "<leader>si",
    "<cmd>PyrightOrganizeImports<CR>",
    { buffer = bufnr },
  })
end

return M
