---@source https://github.com/zapling/mason-lock.nvim/tree/b75e2de585637a61b2fb818dc33dad7863b7b0c4

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
  ---@type ({ name: string, version: string }?)[]
  local entries = {}

  for _, pkg in pairs(pkgs) do
    if not pkg:is_installed() or not pkg.name then
      table.insert(entries, nil)
    else
      table.insert(entries, {
        name = pkg.name,
        version = pkg:get_installed_version(),
      })
    end
  end

  vim.wait(5000, function()
    return #pkgs == #entries
  end)

  -- remove anything that failed
  for i, pkg in ipairs(entries) do
    if pkg == nil then
      entries[i] = nil
    end
  end

  -- sort alphabetically
  table.sort(entries, function(a, b)
    return a.name:lower() < b.name:lower()
  end)

  local file = assert(io.open(M.lockfile_path, "wb"))

  file:write("{\n")

  for i, pkg in ipairs(entries) do
    file:write(([[  %q: %q]]):format(pkg.name, pkg.version))

    if i ~= #entries then
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

local function restore()
  local lock_data = json.from_file(M.lockfile_path)

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
