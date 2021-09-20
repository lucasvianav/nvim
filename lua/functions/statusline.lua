local api = vim.api
local fn  = vim.fn
local lsp = vim.lsp
local cmd = vim.cmd

local M = {}

function M.get_current_files_dir()
    local dir_name = fn.fnamemodify(api.nvim_buf_get_name(0), ':h:t')
    return dir_name ~= '.' and dir_name or '---'
end

return M
