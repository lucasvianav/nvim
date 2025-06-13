local M = {}

local oil_prefix = "oil://"

---@param path string[]
---@return string
function M.join(path)
  local prefix = ""
  if path[1] == oil_prefix then
    table.remove(path, 1)
    prefix = " " .. oil_prefix
  end
  return prefix .. vim.fs.joinpath(unpack(path))
end

---@param filepath string
---@return string? root_dir, string[] relpath_parts, string? dir_prefix
function M.get_path_parts(filepath)
  local is_oil = filepath:starts_with(oil_prefix)
  local root = (vim.uv or vim.loop).cwd()

  if is_oil then
    filepath = filepath:sub(#oil_prefix + 1)
  end
  if filepath:ends_with("/") then
    filepath = filepath:sub(1, #filepath - 1)
  end
  filepath = vim.fs.abspath(filepath)

  if not root or not filepath:starts_with(root) then
    root = vim.fs.root(filepath, {
      ".git",
      "_darcs",
      ".hg",
      ".bzr",
      ".svn",
      "package.json",
      "Makefile",
    }) or vim.env.HOME
  end
  if not root or not filepath:starts_with(root) then
    root = ""
  end

  local root_dir = vim.fs.basename(root or "")
  local relpath = (root and vim.fs.relpath(root, filepath) or filepath):split("/")

  if #relpath == 1 and relpath[1] == "." then
    relpath = {}
  end

  return (#root_dir > 0 and root_dir or nil), relpath, (is_oil and oil_prefix or nil)
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
