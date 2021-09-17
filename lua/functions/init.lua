local function fn(file) return require('functions.' .. file) end

local M = {
    wrappers  = fn('wrappers'),
    sessions  = fn('sessions'),
    mappings  = fn('mappings'),
    utilities = fn('utilities'),
}

return M

