-- DEPENDENCY: typescript (global)

local M = {}

M.filetypes = { 'typescript', 'html' }

--[[
    local language_server_path = vim.fn.stdpath('data') .. '/lspinstall/angular'
    local index_path = language_server_path .. "/node_modules/@angular/language-server/index.js"

    M.cmd = {
        "node",
        index_path,
        "--stdio",
        "--tsProbeLocations",
        language_server_path,
        "--ngProbeLocations",
        language_server_path,
        '--experimental-ivy',
    }
]]--

local language_server_path = vim.fn.stdpath('data') .. '/lspinstall/angular'
local binary_path          = language_server_path .. '/node_modules/.bin/ngserver'

M.cmd = {
    binary_path,
    "--stdio",
    "--tsProbeLocations",
    language_server_path,
    "--ngProbeLocations",
    language_server_path,
    '--experimental-ivy',
}

M.on_new_config = function(new_config, new_root_dir)
    new_config.cmd = cmd
end

M.install_script = [[
! test -f package.json && npm init -y --scope=lspinstall || true
npm install @angular/language-server @angular/language-service typescript --save
]]

return M

