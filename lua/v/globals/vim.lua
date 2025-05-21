-- overwrite global methods
vim.print = _G.P

-- only show deprecation notice if it's coming from my config
local __vim_deprecate = vim.deprecate
vim.deprecate = function(...) ---@diagnostic disable-line
  local config_path = vim.fn.stdpath('config')
  local deprecated_path = debug.getinfo(3).source

  if deprecated_path:starts_with(config_path) then
    return __vim_deprecate(...)
  end
end
