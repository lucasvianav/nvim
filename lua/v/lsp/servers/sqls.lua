local M = {}

M.on_attach = function(client)
  local ok, sqls = pcall(require, "sqls")

  if ok then
    client.commands = sqls.commands
    sqls.setup({ picker = "telescope" })
  end

  require("v.lsp.on_attach").disable_formatting(client)
end

return M
