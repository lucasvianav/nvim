local M = {}

---@return boolean
function M.is_work_computer()
  local res = vim.system({
    'git',
    'config',
    'get',
    'user.email',
  }, { text = true, timeout = 100 }):wait()
  local email = vim.trim(res.stdout or "")
  return email:ends_with("@brex.com")
end

return M
