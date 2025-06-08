local wrappers = require("v.utils.wrappers")

function _G.t(key)
  return wrappers.termcode(key)
end

function _G.R(module)
  return wrappers.reload(module)
end

function _G.P(...)
  return wrappers.inspect(...)
end

---@generic T
---@param cond boolean|fun(...: T): boolean
---@param ... `T`
---@return T
function _G.PC(cond, ...)
  if type(cond) == "function" then
    cond = cond(...)
  end

  if cond then
    return wrappers.inspect(...)
  end

  return ...
end

_G.D = wrappers.dump_inspection

-- load string globals
require("v.globals.string")
require("v.globals.tables")
require("v.globals.v")
require("v.globals.vim")
