local M = {}

M.command = function(lhs, rhs, opts)
    opts = vim.tbl_extend('force', {
        def_bang = true,
        nargs = 0,
    }, opts or {})
    local bang = opts.def_bang
    opts.def_bang = nil

    local cmd = 'command' .. (bang and '!' or '')

    for opt, value in pairs(opts) do
        if value then
            local setv = type(value) ~= 'boolean'
            cmd = ('%s -%s'):format(cmd, opt) .. (setv and '=' .. value or '')
        end
    end

    cmd = ('%s %s %s'):format(cmd, lhs, rhs)

    vim.api.nvim_command(cmd)
end

return M
