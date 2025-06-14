local M = {}

---@alias DevEnv "dev"|"remote"|"work"

---@return boolean
local function is_work_computer()
  local res = vim
    .system({
      "git",
      "config",
      "--get",
      "user.email",
    }, { text = true, timeout = 100 })
    :wait()
  return vim.trim(res.stdout or ""):ends_with("@brex.com")
end

---@return DevEnv
function M.get_dev_env()
  local env_var = vim.env.DEVENV or vim.env.DEV_ENV --[[@as string?]]
  if env_var and env_var:lower() == "remote" then
    return "remote"
  elseif is_work_computer() then
    return "work"
  else
    return "dev"
  end
end

return M
