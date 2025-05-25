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

function _G.D(...)
  return wrappers.dump_text(...)
end

-- load string globals
require("v.globals.string")
require("v.globals.tables")
require("v.globals.v")
require("v.globals.vim")
