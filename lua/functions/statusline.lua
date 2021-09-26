local api = vim.api
local fn  = vim.fn
local lsp = vim.lsp
local cmd = vim.cmd

local M = {}

function M.get_current_files_dir()
    local dir_name = fn.fnamemodify(api.nvim_buf_get_name(0), ':h:t')
    return dir_name ~= '.' and dir_name or '---'
end

function M.get_line_percentage()
    local current = fn.line('.')
    local last    = fn.line('$')

    if current == 1 then
        return '  Top '
    elseif current == last then
        return '  Bot '
    end

    local percentage = math.modf((current / last) * 100)
    return '  ' .. (percentage > 0 and percentage .. '% ' or 'Top ')
end

return M
