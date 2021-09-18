local api = vim.api
local fn  = vim.fn
local lsp = vim.lsp
local cmd = vim.cmd

local M = {}

function M.check_width()
    local squeeze_width = fn.winwidth(0) / 2
    return squeeze_width > 30
end

function M.get_current_files_dir()
    local dir_name = fn.fnamemodify(api.nvim_buf_get_name(0), ':h:t')
    return dir_name ~= '.' and dir_name or '---'
end

return M
