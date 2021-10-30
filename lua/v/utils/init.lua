local fn = vim.fn
local cmd = vim.api.nvim_command

local M = {}

M.colors = require('v.utils.colors')
M.ascii = require('v.utils.ascii')

-- TODO: great utilities https://github.com/JoosepAlviste/dotfiles/blob/master/config/nvim/lua/j/utils.lua
-- TODO: https://github.com/jose-elias-alvarez/dotfiles/blob/main/.config/nvim/lua/utils.lua
-- TODO: function to read last 500 lines from lsp log
-- TODO: https://gitlab.com/yorickpeterse/dotfiles/-/blob/c2fd334e7690b1955a59b9f3f92149dbfb88f9f8/dotfiles/.config/nvim/lua/dotfiles/abbrev.lua

--[[
Deletes all trailing whitespaces in a file if it's not binary nor a diff.
]]
function M.trim_trailing_whitespaces()
    local o = vim.o
    if not o.binary and o.filetype ~= 'diff' then
        local current_view = fn.winsaveview()
        cmd([[keeppatterns %s/\s\+$//e]])
        fn.winrestview(current_view)
    end
end

--[[
Sources the `.nvimrc` file at the `cwd` if it's under `$WORK_DIR`.
]]
function M.source_local_config()
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
    local filepath = vim.api.nvim_buf_get_name('.')
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
function M.reload_or_source_current()
    local filetype = vim.opt_local.ft._value
    local action

    if filetype == 'lua' then
        require('v.utils.wrappers').reload(_get_current_require_path())
        action = 'Reloaded '
    elseif filetype == 'vim' then
        cmd('source %')
        action = 'Sourced '
    else
        return
    end

    vim.notify(action .. '"' .. vim.fn.expand('%') .. '".', 'info', {
        title = 'File reloading...',
    })
end

--[[
Sets all VimL options for a plugin from a `opts` table.
]]
function M.set_viml_options(lead, opts, unique_value)
    lead = lead or ''

    local no_uppercase_initial = lead:match('^[^A-Z]')
    local is_caps_lock = lead:match('^[A-Z]+$')
    local has_no_separator = lead:match('[a-zA-Z0-9]$')

    if (no_uppercase_initial or is_caps_lock) and has_no_separator then
        lead = lead .. '_'
    end

    if unique_value then
        for i, option in ipairs(opts) do
            vim.g[lead .. option] = unique_value
            opts[i] = nil
        end
    end

    for option, value in pairs(opts) do
        vim.g[lead .. option] = value
    end
end

return M