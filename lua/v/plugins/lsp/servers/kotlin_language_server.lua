local M = {}

M.filetypes = {
  'kotlin',
}

M.root_markers = {
  'settings.gradle',
  'settings.gradle.kts',
  'build.xml',
  'pom.xml',
  'build.gradle',
  'build.gradle.kts',
  'maven_install.json',
}

M.rootMarkers = M.root_markers

local ok, lspconfig_utils = pcall(require, 'lspconfig.util')
if ok then
  M.root_dir = lspconfig_utils.root_pattern(unpack(M.root_markers))
end

M.init_options = {
  storagePath = { vim.fn.expand('$HOME') .. '/.kotlin_lsp_data' },
}

return M
