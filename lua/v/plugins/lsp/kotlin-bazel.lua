local utils = require("v.utils.lsp")
local config = utils.make_config()

local custom_config_path = "v.plugins.lsp.servers.kotlin_bazel_lsp"
local has_custom_config, custom_config = pcall(require, custom_config_path)

if has_custom_config then
  config = vim.tbl_deep_extend("force", config, custom_config)
end

require("kotlin_bazel").setup({ config = config })
