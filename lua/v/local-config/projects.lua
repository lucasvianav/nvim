local M = {}

M.allowed_projects = require('v.utils.wrappers').expand_in_list({
  vim.fn.stdpath('config'),
})

---Validate if this project is allowed to have a local configuration
---@param project_path string?
---@return boolean
M.is_allowed = function(project_path)
  return project_path ~= nil and vim.tbl_contains(M.allowed_projects, vim.fn.expand(project_path))
end

return M
