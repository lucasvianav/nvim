local fn = vim.fn
local M = {}

M.path_separator = "/"

local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win32unix") == 1
if is_windows then
  M.path_separator = "\\"
end

---Joins an arbitrary number of paths together
---@param ... string The paths to join
---@return string string The resulting path
M.join = function(...)
  local args = { ... }
  if #args == 0 then
    return ""
  end

  local all_parts = {}

  -- if we have a leading /, add an empty first element
  -- to the table so it also gets included in the output
  if type(args[1]) == "string" and args[1]:sub(1, 1) == M.path_separator then
    all_parts[1] = ""
  end

  for _, arg in ipairs(args) do
    vim.list_extend(all_parts, require('v.utils.strings').split(arg, M.path_separator))
  end

  return table.concat(all_parts, M.path_separator)
end

---@param file_path string
---@returns boolean
M.file_exists = function(file_path)
  return fn.filereadable(file_path) == 1
end

return M
