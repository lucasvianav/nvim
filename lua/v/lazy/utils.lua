local M = {}

M.paths = {
  plugins = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
  lazy = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "lazy.nvim"),
  cache = vim.fs.joinpath(vim.fn.stdpath("state"), "lazy", "pkg-cache.lua"),
  rocks = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "lazy-rocks"),
  state = vim.fs.joinpath(vim.fn.stdpath("state"), "lazy", "state.json"),
  lockfile = vim.fs.joinpath(vim.fn.stdpath("config"), "lazy-lock.json"),
}

function M.ensure_installed()
  local ok = pcall(require, "lazy")

  if not (vim.uv or vim.loop).fs_stat(M.paths.lazy) and not ok then
    M.download()
  end

  vim.opt.rtp:prepend(M.paths.lazy)
end

function M.download()
  vim.notify("Downloading Lazy...", vim.log.levels.INFO, { title = "lazy.nvim" })

  for _, path in pairs(M.paths) do
    vim.fn.delete(path, "rf")
  end

  local branch = "stable"
  local lockfile = require("v.utils.json").from_file(M.paths.lockfile)
  if lockfile and lockfile["lazy.nvim"] then
    local locked = lockfile["lazy.nvim"] --[[@as {branch: string, commit: string}]]
    branch = #(locked.commit:trim()) > 0 and locked.commit:trim() or locked.branch:trim()
  end

  local res = vim
    .system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=" .. branch,
      "https://github.com/folke/lazy.nvim.git",
      M.paths.lazy,
    })
    :wait()

  if res.code ~= 0 then
    vim.notify(
      "Failed to clone Lazy. Error code " .. res.code .. ".",
      vim.log.levels.ERROR,
      { title = "lazy.nvim" }
    )
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { res.stderr, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    return
  end

  vim.notify("Successfully downloaded Lazy", vim.log.levels.INFO, { title = "lazy.nvim" })
end

---@param plugin string
---@return boolean
function M.is_installed(plugin)
  local ok, installed = pcall(function()
    return require("lazy").check({ plugins = { plugin }, show = false })._plugins[plugin]._.installed
  end)
  return ok and installed
end

---@param plugin string
---@return boolean
function M.is_loaded(plugin)
  if package.loaded[plugin] then
    return true
  end
  local ok, loaded = pcall(function()
    return require("lazy").check({ plugins = { plugin }, show = false })._plugins[plugin]._.loaded
      ~= nil
  end)

  return ok and loaded
end

---@param plugin string
---@return boolean
function M.load(plugin)
  local ok, _ = pcall(function()
    require("lazy").load({ plugins = { plugin }, show = false })
  end)
  return ok and M.is_loaded(plugin)
end

return M
