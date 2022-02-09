local api = vim.api
local fn = vim.fn

local M = {}

--  _____ _   _ _   _  ____ _____ ___ ___  _   _ ____
-- |  ___| | | | \ | |/ ___|_   _|_ _/ _ \| \ | / ___|
-- | |_  | | | |  \| | |     | |  | | | | |  \| \___ \
-- |  _| | |_| | |\  | |___  | |  | | |_| | |\  |___) |
-- |_|    \___/|_| \_|\____| |_| |___\___/|_| \_|____/

---Returns the current file's directory if it has one, "---" otherwise.
function M.get_current_files_dir()
    local dir_name = fn.fnamemodify(api.nvim_buf_get_name(0), ':h:t')
    return dir_name ~= '.' and dir_name or '---'
end

---Returns the current line percentage (cursor position/lines in file).
function M.get_line_percentage()
    local current = fn.line('.')
    local last = fn.line('$')

    if current == 1 then
        return '  Top '
    elseif current == last then
        return '  Bot '
    end

    local percentage = math.modf((current / last) * 100)
    return '  ' .. (percentage > 0 and percentage .. '% ' or 'Top ')
end

---Returns the column the cursor currently in.
function M.get_column()
    local tbl = vim.api.nvim_win_get_cursor(0)
    return '  ' .. (tbl[2] + 1) .. ' '
end

return M
