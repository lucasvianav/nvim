local M = {}

-- source: https://github.com/mfussenegger/nvim-lint

---@type EfmExtensionConfig
M.config = {
  enabled = true,
  rootMarkers = {},
  lintStdin = true,
  lintCommand = table.concat({
    "systemdlint",
    "--messageformat='{path}:{line}:{severity}:{id} {msg}'",
  }, " "),
  lintFormats = { "%f:%l:%t:%n %m" },
}

return M
