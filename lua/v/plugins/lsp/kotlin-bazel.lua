local config = require("v.utils.lsp").make_config()
local custom_conf_ok, custom_conf = pcall(require, "v.plugins.lsp.servers.kotlin_bazel_lsp")

if custom_conf_ok and custom_conf and custom_conf.config then
  config = vim.tbl_deep_extend("force", config, custom_conf.config)
end

require("kotlin_bazel").setup({ config = config })
