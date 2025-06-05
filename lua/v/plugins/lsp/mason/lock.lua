---adapted from https://github.com/zapling/mason-lock.nvim/tree/b75e2de585637a61b2fb818dc33dad7863b7b0c4

local M = {}

local json = require("v.utils.json")
local registry = require("mason-registry")
local restore_in_progress = false

M.lockfile_path = vim.fs.joinpath(vim.fn.stdpath("config"), "mason-lock.json")

---@param desc string
---@param level vim.log.levels
local function notify(desc, level)
  vim.notify(desc, level, { title = "mason.nvim" })
end

local function save()
  if restore_in_progress then
    return
  end

  local pkgs = registry.get_installed_packages()
  local pkg_utils = require("v.lsp.packages")

  ---Mappings between the LSP servers' names in Mason and in nvim-lspconfig
  local lsp_name_map = require("mason-lspconfig.mappings").get_mason_map()
  ---Uses the LSP servers' names in nvim-lspconfig
  local ensure_installed = table.merge_lists({
    vim.tbl_keys(pkg_utils.servers),
    vim.tbl_keys(pkg_utils.formatters),
  })
  ---Uses the LSP servers' names in Mason
  ---@type table<string, string>
  local lock_data = json.from_file(M.lockfile_path) or {}
  ---Uses the LSP servers' names in Mason
  ---@type table<string, string>
  local in_lockfile_but_not_installed = vim.deepcopy(lock_data, true)
  ---Uses the LSP servers' names in Mason
  ---@type ({ name: string, version: string }?)[]
  local installed_entries = {}

  -- save versions of installed packages
  for _, pkg in pairs(pkgs) do
    table.insert(installed_entries, (pkg:is_installed() and pkg.name) and {
      name = pkg.name,
      version = pkg:get_installed_version(),
    } or nil)
  end

  vim.wait(5000, function()
    return #pkgs == #installed_entries
  end)

  -- save versions of intalled pkgs to lockfile data
  for _, pkg in ipairs(installed_entries) do
    if pkg ~= nil then
      lock_data[pkg.name] = pkg.version
      in_lockfile_but_not_installed[pkg.name] = nil
    end
  end

  -- if pkg is in lockfile but no longer installed and is also not
  -- in `ensure_installed`, we should remove it from the lockfile
  for pkg, _ in pairs(in_lockfile_but_not_installed) do
    if not vim.tbl_contains(ensure_installed, lsp_name_map.package_to_lspconfig[pkg]) then
      lock_data[pkg] = nil
    end
  end

  ---@type { name: string, version: string }[]
  local res = table.map_items(lock_data, function(k, v)
    return { name = k, version = v }
  end)

  -- sort alphabetically
  table.sort(res, function(a, b)
    return a.name:lower() < b.name:lower()
  end)

  local file = assert(io.open(M.lockfile_path, "wb"))

  file:write("{\n")

  for i, pkg in ipairs(res) do
    file:write(("    %q: %q"):format(pkg.name, pkg.version))

    if i ~= #res then
      file:write(",\n")
    end
  end

  file:write("\n}")
  file:close()

  notify("Lockfile successfully updated.\nSee: " .. M.lockfile_path, vim.log.levels.INFO)
end

local function save_catching()
  local ok, error = pcall(save)
  if not ok then
    notify("Failed writing lockfile.\n" .. error, vim.log.levels.ERROR)
    require("v.utils.log").log(ok, error)
  end
end

-- TODO: restoring should only install:
--    - packages that are already installed (restoring them to their locked version if any)
--    - packages in `ensure_installed` *for the current env*
-- it should also not uninstall any packages
local function restore()
  local lock_data = json.from_file(M.lockfile_path)

  -- local pkg_utils = require("v.lsp.packages")
  -- local ensure_installed = table.merge_lists({
  --   pkg_utils.in_env(pkg_utils.servers),
  --   pkg_utils.in_env(pkg_utils.formatters),
  -- })

  if not lock_data then
    notify("Lockfile does not exist.", vim.log.levels.ERROR)
    return
  end

  restore_in_progress = true

  local ui = require("mason.ui")
  ui.open()

  local started = {}
  local finished_handles = {}

  for name, version in pairs(lock_data) do
    table.insert(started, name)

    local pkg = registry.get_package(name)
    local handle = pkg:install({
      version = version,
    })

    handle:once("closed", function()
      table.insert(finished_handles, name)
    end)
  end

  local ok, status = vim.wait(1000 * 60, function()
    return #finished_handles == #started
  end, 300)

  if not ok then
    if status == -1 then
      notify(
        "Mason package installation timed out when restoring from lockfile.",
        vim.log.levels.ERROR
      )
    elseif status == -2 then
      notify(
        "Mason package installation was interruped when restoring from lockfile.",
        vim.log.levels.ERROR
      )
    end
  else
    notify("Package versions successfully resotre from lockfile.", vim.log.levels.INFO)
  end

  restore_in_progress = false
end

local function add_commands()
  vim.api.nvim_create_user_command("MasonLock", save, {
    desc = "Write current package versions to the Mason lockfile",
  })
  vim.api.nvim_create_user_command("MasonLockRestore", restore, {
    desc = "Re-install Mason packages with the version specified in the lockfile",
  })
end

local function add_event_listeners()
  registry:on(
    "package:install:success",
    vim.schedule_wrap(function(
      _ --[[pkg]],
      _ --[[handle]]
    )
      save_catching()
    end)
  )
  registry:on(
    "package:uninstall:success",
    vim.schedule_wrap(function(
      _ --[[pkg]],
      _ --[[handle]]
    )
      save_catching()
    end)
  )
end

function M.setup()
  add_commands()
  add_event_listeners()
end

return M
