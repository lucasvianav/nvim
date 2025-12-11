local M = {}

M.config = ({ pcall(require, "efmls-configs.formatters.biome") })[2]

if M.config and M.config.formatCommand then
  M.config.formatCommand = M.config.formatCommand:gsub("check", "check --unsafe")
end

return M
