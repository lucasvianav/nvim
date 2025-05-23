local M = {}

---@param content string
function M.copy(content)
  local temp_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_text(temp_buf, 0, 0, 0, 0, { content })
  vim.api.nvim_buf_call(temp_buf, function()
    vim.cmd("normal! \"+y$")
  end)
  vim.api.nvim_buf_delete(temp_buf, {})
end

return M
