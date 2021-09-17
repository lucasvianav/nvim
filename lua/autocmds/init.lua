local function autocmds(file) return require('autocmds.' .. file) end

local M = {
    sessions = autocmds('sessions'),
}

return M

