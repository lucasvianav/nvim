local M = {}

M.config = {
  root_markers = { ".git" },
  rootMarkers = { ".git" },
  root_dir = require("lspconfig.util").root_pattern(".git"),
}

return M
