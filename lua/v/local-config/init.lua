---Module responsible for loading local configuration in project, if allowed.
---@return {config: LocalNvimConfig?}


local M = {
  ---@type LocalNvimConfig?
  config = nil
}

local projects = require('v.local-config.projects')
local cwd = vim.uv.cwd()

if projects.is_allowed(cwd) then
  M.config = require('v.local-config.bootstrap').config
end

return M
