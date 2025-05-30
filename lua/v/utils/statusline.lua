local M = {}

local oil_prefix = "oil://"

---@param path string
---@param is_dir boolean
---@return string
function M.with_prefix_if_dir(path, is_dir)
  if not is_dir then
    return path
  end

  local prefix = path:starts_with("/") and oil_prefix:sub(1, #oil_prefix - 1) or oil_prefix
  return prefix .. path
end

---@param filepath string
---@return string? root_dir, string[] relpath_parts, boolean is_dir
function M.get_path_parts(filepath)
  local is_oil = filepath:starts_with(oil_prefix)
  local root = vim.uv.cwd()

  if is_oil then
    filepath = filepath:sub(#oil_prefix + 1)
  end
  if filepath:ends_with("/") then
    filepath = filepath:sub(1, #filepath - 1)
  end

  if not root or not filepath:starts_with(root) then
    root = vim.fs.root(filepath, { ".git" }) or vim.env.HOME
  end

  local root_dir = vim.fs.basename(root or "")
  local relpath = (root and vim.fs.relpath(root, filepath) or filepath):split("/")

  return (#root_dir > 0 and root_dir or nil), relpath, is_oil
end

---@return string percentage including %
function M.get_line_percentage()
  local current = vim.fn.line(".")
  local last = vim.fn.line("$")
  local percentage = math.modf((current / last) * 100)
  return percentage .. "%%"
end

---@return boolean
function M.buf_has_lsp_attached()
  local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
  return vim.iter(clients):any(function(it) --[[@param it vim.lsp.Client]]
    return it.name ~= "efm"
  end)
end

---@return boolean
function M.buf_has_formatter_attached()
  local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
  return vim.iter(clients):any(function(it)
    return (it --[[@as vim.lsp.Client]]).name == "efm"
  end)
end

return M
