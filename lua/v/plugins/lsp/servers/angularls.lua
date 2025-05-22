local M = {}

local ok, lspconfig_utils = pcall(require, "lspconfig.util")

if ok then
  M.root_dir = lspconfig_utils.root_pattern("angular.json")
end

return M
