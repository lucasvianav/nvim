local o = vim.o
local fn = vim.fn
local cmd = vim.cmd
local api = vim.api

local function util(file) return require('utils.' .. file) end

local M = {
    colors     = util('colors'),
    ascii      = util('ascii'),
}

return M
