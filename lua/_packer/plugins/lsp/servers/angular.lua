-- ISSUE: https://github.com/kabouzeid/nvim-lspinstall/issues/72

local M = {}

local data_path = vim.fn.stdpath('data')
local language_server_path = data_path .. '/lspinstall'
local full_path    = language_server_path .. "/@angular/language-server/index.js"

M.cmd = {
    "node",
    full_path,
    "--stdio",
    "--tsProbeLocations",
    language_server_path, 
    "--ngProbeLocations",
    language_server_path, 
}

M.install_script = [[
! test -f package.json && npm init -y --scope=lspinstall || true
npm install @angular/language-server @angular/language-service typescript
]]

return M

