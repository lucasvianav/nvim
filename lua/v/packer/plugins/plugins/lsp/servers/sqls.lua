local M = {}

M.on_attach = function(client)
  local ok, sqls = require("v.utils.packer").load_and_require_plugin("sqls")

  if ok then
    client.commands = sqls.commands
    sqls.setup({ picker = "telescope" })
  end

  require("v.lsp.on_attach").disable_formatting(client)
end

return M
