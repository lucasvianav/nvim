local function fn(file) return require('functions.' .. file) end

local M = {
    wrappers  = fn('wrappers'),
    autocmds  = fn('autocmds'),
    mappings  = fn('mappings'),
    utilities = fn('utilities'),
}

return M

