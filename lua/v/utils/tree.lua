local M = {}

---Open NvimTree with :NvimTreeFind file and closes it with :NvimTreeClose.
function M.nvim_tree_toggle()
  local is_nvim_tree_loaded, api = pcall(require, "nvim-tree.api")

  if is_nvim_tree_loaded then
    api.tree.collapse_all()
    api.tree.toggle({ find_file = true })
  end
end

return M
