local M = {}

M.on_attach = function(client, bufnr)
  local ok, sqls = pcall(require, "sqls")

  if ok then
    client.commands = sqls.commands
    sqls.on_attach(client, bufnr)
  end

  require("v.lsp.on_attach").disable_formatting(client)
end

return M
