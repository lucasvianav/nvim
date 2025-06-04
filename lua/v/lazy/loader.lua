local M = {}
local log_not_found_configs = true

---@param plugin_name string
---@param type "plugin"|"theme"
---@param group "appearance"|"general"|"git"|"lsp"|"navigation"|"syntax"?
---@return string?
local function get_plugin_config_module(plugin_name, type, group)
  local res = "v." .. type .. "s."

  if type == "plugin" then
    if not group then
      local message = ("No group provided to plugin [%s], configuration not found."):format(
        plugin_name
      )
      vim.notify(message, vim.log.levels.ERROR, { title = "lazy.nvim" })
      require("v.utils.log").log(message)
      return nil
    end

    res = res .. group .. "."
  end

  return res .. plugin_name
end

---@param plugin_name string
---@param type "plugin"|"theme"
---@param group "appearance"|"general"|"git"|"lsp"|"navigation"|"syntax"?
---@return fun(plugin: LazyPlugin, opts: table)?
local function get_plugin_config(plugin_name, type, group)
  local module = get_plugin_config_module(plugin_name, type, group)

  if not module and type == "plugin" then
    return nil
  end

  local colorscheme = require("v.settings").appearance.colorscheme
  local is_primary_colorscheme = type == "theme" and plugin_name == colorscheme

  return function(_, _)
    local ok, config = pcall(require, module)

    if log_not_found_configs and not ok then
      require("v.utils.log").log(plugin_name, type, group, module, config)
    end

    if is_primary_colorscheme then
      vim.cmd.colorscheme(plugin_name)
      -- TODO: move to autocmd
      require("v.settings").appearance.post_colorscheme_hook()
    end
  end
end

---@param spec LazyPluginSpec
---@return string?
local function get_plugin_name(spec)
  if spec.name then
    return spec.name
  end

  local plugin = spec[1] or spec.dir or spec.url
  if not plugin then
    return
  end

  local res = plugin:lower()

  local matchers = {
    "^.+%/",       -- leading path
    "%.[^.]+$",    -- trailing extension
    "[-_.]n?vim$", -- "-vim", "_vim", ".vim", "-nvim", "_nvim", ".nvim"
    "^n?vim[-_.]", -- "vim-", "vim_", "vim.", "nvim-", "nvim_", "nvim."
    "[-_.]lua$",   -- "-vim", "_vim", ".vim", "-nvim", "_nvim", ".nvim"
    "^lua[-_.]",   -- "vim-", "vim_", "vim.", "nvim-", "nvim_", "nvim."
  }

  for _, pat in ipairs(matchers) do
    res = res:gsub(pat, "")
  end

  return res
end

---@param specs LazyPluginSpec[]
---@param group "appearance"|"general"|"git"|"lsp"|"navigation"|"syntax"
function M.process_plugins(specs, group)
  local res = {}

  for _, spec in ipairs(specs) do
    local name = get_plugin_name(spec)

    if name and not spec.opts and not spec.config then
      spec.config = get_plugin_config(name, "plugin", group)
    end

    table.insert(res, spec)
  end

  return res
end

---@param specs (LazyPluginSpec|string)[]
function M.process_themes(specs)
  local res = {}

  for _, it in ipairs(specs) do
    local spec = type(it) == "string" and { it } or it --[[@as LazyPluginSpec]]
    local name = get_plugin_name(spec)
    local is_main_colorscheme = require("v.settings").appearance.colorscheme == name

    if name and not spec.opts and not spec.config then
      spec.config = get_plugin_config(name, "theme")
    end

    -- if spec.cond == nil then
    --   spec.cond = is_main_colorscheme
    -- end

    if is_main_colorscheme then
      spec.lazy = false
      spec.priority = 1000
    else
      spec.lazy = spec.lazy == nil and true or spec.lazy
    end

    table.insert(res, spec)
  end

  return res
end

return M
