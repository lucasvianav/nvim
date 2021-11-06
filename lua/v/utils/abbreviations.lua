local M = {}

---@param mode string
---@return boolean is_mode_valid
local function validate_mode(mode)
    if type(mode) ~= 'string' then
        vim.api.nvim_notify('Invalid mode. See `:messages`', vim.log.levels.ERROR, {
            title = 'Abbreviation',
        })
        require('v.utils.wrappers').inspect(mode)
    elseif not string.find('!ci', mode) or #mode ~= 1 then
        vim.api.nvim_notify('Invalid mode: ' .. mode, vim.log.levels.ERROR, {
            title = 'Abbreviation',
        })
    else
        return true
    end

    return false
end

---Evaluates the result of a command-line abbreviation.
---@param lhs string abbreviation-trigger
---@param rhs string abbreviation-result
M.evaluate_cabbrev = function(lhs, rhs)
    local is_ex = vim.fn.getcmdtype() == ':'
    local cmd = vim.fn.getcmdline()
    local should_expand = cmd:match('^' .. lhs) or cmd:match('|%s*' .. lhs)

    return (is_ex and should_expand) and rhs or lhs
end

---Wrapper for :cabbreviate and :iabbreviate
---@param mode string can be either i (for insert), c (for command-line) or ! (for both)
---@param lhs string abbreviation-trigger
---@param rhs string abbreviation-result
---@return nil
M.abbreviate = function(mode, lhs, rhs)
    if not validate_mode(mode) then
        return
    elseif not type(lhs) == 'string' or not type(rhs) == 'string' then
        vim.api.nvim_notify('Invalid parameter(s).', vim.log.levels.ERROR, {
            title = 'Abbreviation',
        })
        require('v.utils.wrappers').inspect(mode, lhs, rhs)
        return
    end

    if mode == 'i' or mode == '!' then
        vim.api.nvim_command(('iabbrev %s %s'):format(lhs, rhs))
    end

    if mode == 'c' or mode == '!' then
        local path = 'v:lua.require("v.utils.abbreviations").evaluate_cabbrev'
        local cmd = 'cabbrev <expr> %s %s("%s", "%s")'
        vim.api.nvim_command(cmd:format(lhs, path, lhs, rhs))
    end
end

---Wrapper for :cabbreviate
---@param lhs string abbreviation-trigger
---@param rhs string abbreviation-result
M.cabbrev = function(lhs, rhs)
    M.abbreviate('c', lhs, rhs)
end

---Wrapper for :iabbreviate
---@param lhs string abbreviation-trigger
---@param rhs string abbreviation-result
M.iabbrev = function(lhs, rhs)
    M.abbreviate('i', lhs, rhs)
end

---Wrapper for setting multiple abbreviations (`:h :ab`) in one function call
---@param args string[][] list of abbreviation arrays: { mode, lhs, rhs }
---@param mode string use the same mode for all abbreviations --- if you use this, provide only `lhs` and `rhs` in the abbreviation arrays
---@return nil
M.set_abbreviations = function(args, mode)
    if mode and not validate_mode(mode) then
        return
    end

    for _, abbrev_table in ipairs(args) do
        if #abbrev_table == 3 and not mode then
            M.abbreviate(unpack(abbrev_table))
        elseif #abbrev_table == 2 and mode then
            M.abbreviate(mode, unpack(abbrev_table))
        else
            vim.api.nvim_notify('Something wrong... See `:messages`', vim.log.levels.ERRORS, {
                title = 'Setting Abbreviations',
            })
        end
    end
end

return M
