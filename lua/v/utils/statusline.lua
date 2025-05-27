local M = {}

---@param filepath string
---@return string?, string[]
function M.get_path_parts(filepath)
  local root = vim.uv.cwd()

  if not root or not filepath:starts_with(root) then
    root = vim.fs.root(filepath, { ".git" }) or vim.env.HOME
  end

  local root_dir = vim.fs.basename(root or "")
  local relpath = (root and vim.fs.relpath(root, filepath) or filepath):split("/")

  return (#root_dir > 0 and root_dir or nil), relpath
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
  local clients = vim.lsp.get_clients({ buffer = vim.api.nvim_get_current_buf() })
  return vim.iter(clients):any(function(it) --[[@param it vim.lsp.Client]]
    return it.name ~= "efm"
  end)
end

---@return boolean
function M.buf_has_formatter_attached()
  local clients = vim.lsp.get_clients({ buffer = vim.api.nvim_get_current_buf() })
  return vim.iter(clients):any(function(it)
    return (it --[[@as vim.lsp.Client]]).name == "efm"
  end)
end

return M
