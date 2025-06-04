local M = {}
local lazydev_ok, lazydev = pcall(require, "lazydev")

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

M.on_attach = require("v.lsp.on_attach").disable_formatting

return M
