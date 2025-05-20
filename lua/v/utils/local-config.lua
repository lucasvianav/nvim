-- include in path local configurations supported in

local M = {}

local fs = vim.fs
local utils = require('v.utils.paths')

local local_config_dir_path = fs.joinpath(vim.uv.cwd(), ".nvimrc")
local local_config_exists = utils.dir_exists(local_config_dir_path)

if not local_config_exists then
  return M
end

return M
