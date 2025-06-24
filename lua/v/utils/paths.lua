local M = {}

---@param path string
---@returns boolean
M.file_exists = function(path)
  return vim.fn.filereadable(vim.fn.expand(path)) == 1
end

---@param path string
---@returns boolean
M.dir_exists = function(path)
  return vim.fn.isdirectory(vim.fn.expand(path)) == 1
end

---@param path string
---@returns string
M.resolve = function(path)
  return vim.fn.resolve(vim.fn.expand(path))
end

return M
