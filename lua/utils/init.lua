local function util(file) return require('utils.' .. file) end

local M = {
    colors    = util('colors'),
    functions = util('functions'),
    ascii     = util('ascii'),
}

return M
