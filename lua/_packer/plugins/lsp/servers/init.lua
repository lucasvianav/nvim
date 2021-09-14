local function server(name)
    return require('_packer.plugins.lsp.servers.' .. name)
end

local M = {
    lua = server('lua'),
}

return M
