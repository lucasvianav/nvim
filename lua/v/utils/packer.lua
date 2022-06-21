--  ____  ____  _____     ___  _____ _____
-- |  _ \|  _ \|_ _\ \   / / \|_   _| ____|
-- | |_) | |_) || | \ \ / / _ \ | | |  _|
-- |  __/|  _ < | |  \ V / ___ \| | | |___
-- |_|   |_| \_\___|  \_/_/   \_\_| |_____|

local fn = vim.fn
local cmd = vim.api.nvim_command

local function __get_local_plugin_path(arg)
  local path = arg
  local plugins_dir = os.getenv('HOME') .. '/nvim-plugins/'
  local implicit_path = [[^[^\~/.]\+\|^\[^\/]*$]*$\|^\[^\~/]*]]

  if vim.regex(implicit_path):match_str(path) then
    path = plugins_dir .. path
  end

  return path
end

local function __get_plugin_name(arg)
  if type(arg) ~= 'string' then
    return
  end

  local name = ''

  local re = {
    leadingPath = [[^.\+\/]], -- matches leading path
    extension = [[\.[^.]\+$]], -- matches trailing extension

    vim = [[[-_]n\?vim\|n\?vim]] .. '[-_]', -- matches "-vim" or "vim-" (also nvim and _)
    lua = [[[-_]n\?lua\|n\?lua]] .. '[-_]', -- matches "-lua" or "lua-" (also _)
  }

  local function subs(regex)
    return fn.substitute(name, re[regex], '', 'g')
  end

  name = arg:lower()
  name = subs('leadingPath')
  name = subs('extension')
  name = subs('vim')
  name = subs('lua')

  return name
end

local function __get_config_setup_str(module, plugin_name, is_theme)
  if type(module) ~= 'string' or type(plugin_name) ~= 'string' then
    return
  end

  local require_str = ([[
        local ok, module = pcall(require, '%s')

        if not ok then
            require('v.utils.log').log(module)
        end
    ]]):format(module)

  if is_theme and plugin_name then
    require_str = ([[%s
            local settings = require('v.settings').appearance
            local colorscheme = settings.colorscheme

            if colorscheme == '%s' then
                vim.api.nvim_command('colorscheme %s')
                settings.post_colorscheme_hook()
            end
        ]]):format(require_str, plugin_name, plugin_name)
  end

  return require_str
end

local function __get_config_filepath(plugin_name, plugin_type, category)
  if type(plugin_name) ~= 'string' or type(plugin_type) ~= 'string' then
    return
  end

  local path = 'v.' .. plugin_type .. 's.'

  if category then
    path = path .. category .. '.'
  end

  return path .. plugin_name
end

local function __get_plugin_table(args, plugin_type, category)
  if type(args) == 'string' then
    args = { args }
  end

  if not args or #args == 0 or not args[1] then
    return
  end

  local name = args.as or __get_plugin_name(args[1])
  local is_theme = plugin_type == 'theme'
  local opts = args.__opts or {}
  args.__opts = nil -- we don't wanna pass this do packer

  if opts.dev then
    args[1] = __get_local_plugin_path(args[1])

    if fn.isdirectory(args[1]) == 0 then
      if opts.fallback then
        args[1] = opts.fallback
        name = args.as or __get_plugin_name(args[1])
      else
        vim.notify(
          'The plugin "'
            .. name
            .. '" was not found at: "'
            .. args[1]
            .. '". No fallback was provided.',
          'error'
        )

        return
      end
    end
  end

  if not args.config or (args.use_setup and not args.setup) then
    local config_path = __get_config_filepath(name, plugin_type, category)
    local require_str = __get_config_setup_str(config_path, name, is_theme)

    if opts.setup then
      args.setup = require_str
    else
      args.config = require_str
    end
  end

  if is_theme and not args.cond then
    args.cond = "require('v.settings').appearance.colorscheme == '" .. name .. "'"
  end

  return args
end

local function __load_plugins(table, use)
  for category, plugins in pairs(table.plugins) do
    for _, args in ipairs(plugins) do
      local plugin = __get_plugin_table(args, 'plugin', category)
      if args then
        use(plugin)
      end
    end
  end

  for _, args in ipairs(table.themes) do
    local theme = __get_plugin_table(args, 'theme')
    if args then
      use(theme)
    end
  end
end

--  ____  _   _ ____  _     ___ ____
-- |  _ \| | | | __ )| |   |_ _/ ___|
-- | |_) | | | |  _ \| |    | | |
-- |  __/| |_| | |_) | |___ | | |___
-- |_|    \___/|____/|_____|___\____|

local M = {}

-- TODO: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/utils/plugins.lua

M.path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
M.compile_path = fn.stdpath('config') .. '/lua/packer_compiled.lua'

--- Loads packer.nvim (since it's lazy-loaded) and pcall requires it.
function M.get_packer()
  pcall(cmd, 'packadd packer.nvim')
  local is_loaded, packer = pcall(require, 'packer')

  return is_loaded, packer
end

function M.init(packer)
  if packer then
    packer.init({
      display = {
        open_fn = function()
          return require('packer.util').float({ border = 'single' })
        end,
        prompt_border = 'single',
      },
      profile = {
        enable = true,
        treshold = 1,
      },
      compile_path = M.compile_path,
    })
  end
end

function M.setup_plugins(packer)
  if not packer then
    local is_loaded
    is_loaded, packer = M.get_packer()

    if not is_loaded then
      return
    end
  end

  local table = {
    plugins = require('v.packer.plugins'),
    themes = require('v.packer.themes'),
  }

  __load_plugins(table, packer.use)
end

function M.setup(packer)
  if not packer then
    local is_loaded
    is_loaded, packer = M.get_packer()

    if not is_loaded then
      return
    end
  end

  M.init(packer)
  M.setup_plugins(packer)
end

function M.is_plugin_loaded(plugin)
  local plugin_list = packer_plugins or {}
  return plugin_list[plugin] and plugin_list[plugin].loaded
end

function M.is_plugin_installed(plugin)
  local plugin_list = packer_plugins or {}
  return plugin_list[plugin]
end

return M
