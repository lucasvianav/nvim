local fn = vim.fn

local M = {}

M.path = fn.stdpath('config') .. '/log.txt'

function M.log(...)
    local content = require('v.utils.wrappers').format_for_inspection(...)
    local fp      = io.open(M.path, 'a+')
    local date = os.date('*t')

    date = {
        date.year,
        date.month,
        date.day,
        date.hour,
        date.min,
        date.sec,
    }

    fp:seek('end')
    fp:write(string.format('%s/%s/%s - %s:%s:%s :::\n', unpack(date)))
    fp:write(content)
    fp:write('\n================================================\n\n\n\n\n')

    fp:close()
end

function M.clean()
    local fp = io.open(M.path, 'w')
    fp:close()
end

return M
