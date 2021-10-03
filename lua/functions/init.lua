local function fn(file)
    return require('functions.' .. file)
end

local M = {
    lsp = fn('lsp'),
    mappings = fn('mappings'),
    plugins = fn('plugins'),
    sessions = fn('sessions'),
    statusline = fn('statusline'),
    utilities = fn('utilities'),
    wrappers = fn('wrappers'),
}

return M
