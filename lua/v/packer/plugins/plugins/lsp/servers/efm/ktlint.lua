local M = {}

local tbl_utils = require("v.utils.tables")
local local_config = (v.local_config.efm or {}).ktlint or {}

---@type LocalKtlintConfig
local default_config = {}
---@type LocalKtlintConfig
local cfg = vim.tbl_deep_extend("force", default_config, local_config)

local ktlint_cmd_parts = tbl_utils.merge_lists({
  "ktlint",
  { "-l", "none" },
  cfg.ruleset_jar_path and { "-R", cfg.ruleset_jar_path } or {},
  cfg.baseline_file_path and { "--baseline", cfg.baseline_file_path } or {},
})
local ktlint_cmd = table.concat(ktlint_cmd_parts, " ")

---@type LinterConfig
M.config = {
  lintFormats = {
    "%f:%l:%c: %m",
  },
  rootMarkers = {
    "ktlint-baseline.xml",
    "BUILD.bazel",
  },
  lintStdin = true,
  lintCommand = ktlint_cmd .. " --stdin",
  formatStdin = true,
  formatCommand = ktlint_cmd .. " -F --stdin || true",
}

return M
