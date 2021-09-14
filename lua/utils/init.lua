local function util(file) return require('utils.' .. file) end

local M = {
    colors = util('colors'),
    ascii  = util('ascii'),
}

return M
