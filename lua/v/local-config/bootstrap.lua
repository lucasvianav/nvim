---looks for local configuration in <cwd>/.nvimrc/v/init.lua,
---adds it to the path and reads it. removes it from the path
---and cleans up loaded packages. then returns the local config.
---@return {config: LocalNvimConfig?}

local M = {
  ---@type LocalNvimConfig?
  config = nil,
}

local fs = vim.fs
local utils = require("v.utils.paths")

local config_dir_path = fs.joinpath(vim.uv.cwd(), ".nvimrc", "v")
local config_init_path = fs.joinpath(config_dir_path, "init.lua")
local config_exists = utils.file_exists(config_init_path)

if not config_exists then
  return M
end

-- save initial state
local initial_package_path = package.path
local initial_v_package = package.loaded.v

-- add local config to package path
local config_dir_wildcard = fs.joinpath(config_dir_path, "?.lua")
package.loaded.v = nil
package.path = table.concat({ config_init_path, config_dir_wildcard }, ";") .. package.path

local config_ok, config = pcall(require, "v")

if config_ok then
  M.config = config --[[@as LocalNvimConfig?]]
end

-- restore initial state
package.path = initial_package_path
package.loaded.v = initial_v_package

return M
