local M = {}
local lazydev_ok, lazydev = require("v.utils.packer").load_and_require_plugin("lazydev")

if lazydev_ok then
  lazydev.setup()
end

M.config = {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
    },
  },
}

M.on_attach = require("v.utils.lsp.on_attach").disable_formatting

return M
