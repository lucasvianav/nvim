local M = {}
local lazydev_ok, lazydev

if v.package_manager == "lazy" then
  lazydev_ok, lazydev = pcall(require, "lazydev")
else
  lazydev_ok, lazydev = require("v.utils.packer").load_and_require_plugin("lazydev")
end

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
