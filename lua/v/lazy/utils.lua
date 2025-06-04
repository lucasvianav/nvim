local M = {}

M.paths = {
  plugins = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
  lazy = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "lazy.nvim"),
  cache = vim.fs.joinpath(vim.fn.stdpath("state"), "lazy", "pkg-cache.lua"),
  rocks = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "lazy-rocks"),
  state = vim.fs.joinpath(vim.fn.stdpath("state"), "lazy", "state.json"),
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

  local res = vim
      .system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
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
      { res.stderr,                     "WarningMsg" },
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
  return pcall(
    function()
      require("lazy").check({ plugins = { plugin }, show = false })
    end
  )
end

---@param plugin string
---@return boolean
function M.is_loaded(plugin)
  return package.loaded[plugin] or pcall(
    function()
      require("lazy").check({ plugins = { plugin }, show = false }):is_running()
    end
  )
end

---@param plugin string
---@return boolean
function M.load(plugin)
  return pcall(
    function()
      require("lazy").load({ plugins = { plugin }, show = false })
    end
  ) and M.is_loaded(plugin)
end

return M
