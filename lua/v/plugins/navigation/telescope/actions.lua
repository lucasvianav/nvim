-- TODO: git add (with support for select and batch add)

local actions = require("telescope.actions")
local state = require("telescope.actions.state")
local transform_mod = require("telescope.actions.mt").transform_mod

local M = {}

---@param bufnr number
function M.open_in_diff(bufnr)
  actions.close(bufnr)

  local commit_hash = state.get_selected_entry().value
  local ok, diffview = pcall(require, "diffview")

  if ok then
    diffview.open(commit_hash .. "~1.." .. commit_hash)
  end
end

---@return string?
local function get_selected_entry_filename()
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

---@overload fun(bufnr: integer): nil
---@overload fun(split?: "tab"|"vert"|"hor"): fun(bufnr: integer): nil
function M.open_with_oil(arg)
  local split = type(arg) == "string" and arg or nil
  local buf = type(arg) == "number" and arg or nil
  local fn = function(bufnr)
    local path = get_selected_entry_filename()
    actions.close(bufnr)
    if split then
      vim.api.nvim_exec2(split .. " split", { output = false })
    end
    require("oil").open(path)
  end
  return buf and fn(buf) or fn
end

---@param type 'abs'|'rel'|'name'
---@param bufnr integer?
local function copy_path(type, bufnr)
  local path = get_selected_entry_filename()
  local is_symbols = bufnr
    and (state.get_current_picker(bufnr).prompt_title --[[@as string]]):lower()

  if not path then
    return
  end

  if is_symbols then
    require("v.utils.clipboard").copy(path:split()[1])
    return
  end

  local paths = {
    abs = vim.fs.abspath(path),
    rel = vim.fs.relpath(vim.loop.cwd() or vim.env.HOME, path),
    name = vim.fs.basename(path),
  }
  require("v.utils.clipboard").copy(paths[type])
end

function M.copy_path_abs(bufnr)
  copy_path("abs", bufnr)
end

function M.copy_path_rel(bufnr)
  copy_path("rel", bufnr)
end

function M.copy_file_name(bufnr)
  copy_path("name", bufnr)
end

M = transform_mod(M)
return M
