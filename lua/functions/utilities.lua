local o = vim.o
local fn = vim.fn
local cmd = vim.cmd
local api = vim.api

-- TODO: function to convert table to vim's string-list
-- https://github.com/sindrets/dotfiles/blob/b18533d6f082618233d5178d0e2864987e240a33/.config/nvim/lua/nvim-config/settings.lua#L22-L27
-- https://github.com/JoosepAlviste/dotfiles/blob/b09a4eed7bf4c7862a02aa8b14ffe29896a0bfa5/config/nvim/lua/j/settings.lua#L75-L87

-- TODO: great utilities https://github.com/JoosepAlviste/dotfiles/blob/master/config/nvim/lua/j/utils.lua
-- TODO: https://github.com/jose-elias-alvarez/dotfiles/blob/main/.config/nvim/lua/utils.lua

--[[
Checks if `list` contains the element `x` using binary search. Only useful if `list` is sorted.
]]
function _G.contains_bin(x, list)
    local middle
    local start = 1
    local size = #list

    while start <= size do
        middle = math.floor((start + size) / 2)

        if x == list[middle] then
            return true
        elseif x < list[middle] then
            size = middle - 1
        else
            start = middle + 1
        end
    end

    return false
end

--[[
Checks if `list` contains the element `x`.
]]
function _G.contains(x, list)
    for _, y in pairs(list) do
        if x == y then
            return true
        end
    end

    return false
end

--[[
Deletes all trailing whitespaces in a file if it's not binary nor a diff.
]]
function _G.trim_trailing_whitespaces()
    if not o.binary and o.filetype ~= 'diff' then
        local current_view = fn.winsaveview()
        cmd([[keeppatterns %s/\s\+$//e]])
        fn.winrestview(current_view)
    end
end

--[[
Sources the `.nvimrc` file at the `cwd` if it's under `$WORK_DIR`.
]]
function _G.source_local_config()
    local cwd = fn.getcwd()
    local work_dir = os.getenv('WORK_DIR')
    local regexp = vim.regex('^' .. fn.escape(work_dir, '.'))

    if fn.empty(work_dir) == 0 and regexp:match_str(cwd) then
        cmd('silent! source ' .. cwd .. '/.nvimrc')
    end
end

--[[
Return the path to the current lua file inside `nvim/lua/` in order to require it.
]]
local function _get_current_require_path()
    local filepath = api.nvim_buf_get_name('.')
    local regexp = [[^.\+nvim/lua/\(.\+\)\.lua$]]

    if not vim.regex(regexp):match_str(filepath) then
        return nil
    else
        filepath = fn.substitute(filepath, regexp, [[\1]], '')
        filepath = fn.substitute(filepath, [[\.lua$]], [[]], '')
        filepath = fn.substitute(filepath, '/', '.', 'g')
        return filepath
    end
end

--[[
Sources the current file if it's VimL and reloads (w/ `require`) if it's Lua.
]]
function _G.reload_or_source_current()
    local filetype = vim.opt_local.ft._value
    local action

    if filetype == 'lua' then
        R(_get_current_require_path())
        action = 'Reloaded '
    elseif filetype == 'vim' then
        cmd('source %')
        action = 'Sourced '
    else
        return
    end

    vim.notify(action .. '"' .. vim.fn.expand('%') .. '".', 'info', {
        title = ':R',
    })
end
