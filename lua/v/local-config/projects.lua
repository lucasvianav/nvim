local tbl_utils = require("v.utils.tables")
local M = {}

local ok, local_allowed_projects = pcall(require, "v.local-config.local-projects")
if ok and local_allowed_projects and type(local_allowed_projects) == "table" then
  ---@type string[]
  local_allowed_projects = vim.tbl_filter(function(it)
    return type(it) == "string"
  end, local_allowed_projects)
else
  ---@type string[]
  local_allowed_projects = {}
end

M.allowed_projects = require("v.utils.wrappers").expand_in_list(tbl_utils.merge_lists({
  vim.fn.stdpath("config"),
  local_allowed_projects,
}))

---Validate if this project is allowed to have a local configuration
---@param project_path string?
---@return boolean
M.is_allowed = function(project_path)
  return project_path ~= nil and vim.tbl_contains(M.allowed_projects, vim.fn.expand(project_path))
end

return M
