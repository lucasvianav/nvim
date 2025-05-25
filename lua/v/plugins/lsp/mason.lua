local utils = require("v.utils.lsp")
local servers = require("v.settings.lsp").servers
-- local formatters = require('v.settings.lsp').formatters

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_enable = false,
})

for _, server in ipairs(servers) do
  local config = utils.make_config()
  local has_custom_config, custom_config = pcall(require, "v.plugins.lsp.servers." .. server)

  if custom_config.skip_lsp_setup then
    goto continue
  end

  if has_custom_config and custom_config and custom_config.config then
    config = vim.tbl_deep_extend("force", config, custom_config.config)
  end

  require("lspconfig")[server].setup(config)
  ::continue::
end
