local M = {}

function M.open()
  vim.api.nvim_exec2("silent Dashboard", { output = false })
end

function M.open_in_new_tab()
  vim.api.nvim_exec2("tabnew | silent Dashboard", { output = false })
end

---@param bufnr integer? default 0
---@param alt_file string? default # reg
---@return boolean deleted
function M.delete_buf(bufnr, alt_file)
  bufnr = bufnr or 0
  alt_file = alt_file or vim.fn.getreg("#")

  local deleted = pcall(function()
    vim.api.nvim_buf_delete(bufnr, { force = true })
  end)

  local new_alt_file = vim.fn.getreg("#")

  if deleted and (not new_alt_file or #new_alt_file == 0) and (alt_file and #alt_file > 0) then
    vim.fn.setreg("#", alt_file)
  end

  return deleted
end

function M.quit_if_curr_buf()
  if vim.api.nvim_get_option_value("filetype", { buf = 0 }) ~= "dashboard" then
    return
  end
  if not M.delete_buf() then
    vim.api.nvim_exec2("q", { output = false })
  end
end

return M
