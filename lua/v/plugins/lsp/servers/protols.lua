local M = {}

M.root_markers = { ".git", 'BUILD.bazel' }
M.rootMarkers = M.root_markers

local ok, lspconfig_utils = pcall(require, 'lspconfig.util')
if ok then
  M.root_dir = lspconfig_utils.root_pattern(unpack(M.root_markers))
end

return M
