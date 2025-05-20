local wrappers = require('v.utils.wrappers')

function _G.t(key)
  return wrappers.termcode(key)
end

function _G.R(module)
  return wrappers.reload(module)
end

function _G.P(...)
  return wrappers.inspect(...)
end

function _G.D(...)
  return wrappers.dump_text(...)
end

-- load string globals
require('v.utils.strings')

-- overwrite global methods
vim.print = _G.P

-- only show deprecation notice if it's coming from my config
local __vim_deprecate = vim.deprecate
vim.deprecate = function(...)
  local config_path = vim.fn.stdpath('config')
  local deprecated_path = debug.getinfo(3).source

  if deprecated_path:starts_with(config_path) then
    return __vim_deprecate(...)
  end
end
