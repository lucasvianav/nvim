local actions = require("telescope.actions")
local state = require("telescope.actions.state")
local transform_mod = require("telescope.actions.mt").transform_mod

local M = {}

---@param bufnr number
function M.open_in_diff(bufnr)
  actions.close(bufnr)

  local commit_hash = state.get_selected_entry().value
  local ok, diffview

  if v.package_manager == "lazy" then
    ok, diffview = pcall(require, "diffview")
  else
    ok, diffview = require("v.utils.packer").load_and_require_plugin("diffview.nvim")
  end

  if ok then
    diffview.open(commit_hash .. "~1.." .. commit_hash)
  end
end

---@return string?
local function __get_selected_entry_filename()
  local entry = state.get_selected_entry()

  if entry.path or entry.filename then
    return entry.path or entry.filename
  end

  if entry.bufnr then
    return vim.api.nvim_buf_get_name(entry.bufnr)
  end

  if not entry.value then
    return nil
  end

  local value = type(entry.value) == "table" and entry.display or entry.value
  local sections = vim.split(value, ":")

  return sections[1]
end

---@param type 'abs'|'rel'|'name'
local function __copy_path(type)
  local path = __get_selected_entry_filename()

  if not path then
    return
  end

  local paths = {
    abs = vim.fs.abspath(path),
    rel = vim.fs.relpath(vim.loop.cwd() or vim.env.HOME, path),
    name = vim.fs.basename(path),
  }
  require("v.utils.clipboard").copy(paths[type])
end

function M.copy_path_abs()
  __copy_path("abs")
end

function M.copy_path_rel()
  __copy_path("rel")
end

function M.copy_file_name()
  __copy_path("name")
end

M = transform_mod(M)
return M
