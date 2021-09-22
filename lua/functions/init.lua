local function fn(file) return require('functions.' .. file) end

local M = {
    utilities  = fn('utilities'),
    wrappers   = fn('wrappers'),
    sessions   = fn('sessions'),
    mappings   = fn('mappings'),
    statusline = fn('statusline'),
    lsp        = fn('lsp'),
}

return M

