local fn = vim.fn
local cmd = vim.cmd

local function get_cwd_session_path()
    local expanded_dir = vim.fn.stdpath('data') .. '/sessions/'
    local escaped_cwd  = fn.fnamemodify(fn.getcwd(), ':p:h:gs?/?%?')

    return expanded_dir .. escaped_cwd .. '.vim'
end

local function load_dashboard()
    cmd('silent! Dashboard')
end




--[[
Saves the current dir's session.
]]--
function _G.save_cwd_session()
    local session = get_cwd_session_path()
    cmd('silent! mksession! ' .. session)
end

--[[
Deletes the current dir's session.
]]--
function _G.delete_cwd_session()
    local session = get_cwd_session_path()
    cmd('silent! !rm -f' .. session)
end

--[[
Loads the current dir's session if there is one.
]]--
function _G.load_cwd_session(auto_session_plugin)
    local session = get_cwd_session_path()
    local cmd_custom = 'source ' .. session
    local cmd_plugin = 'RestoreSession'

    if fn.filereadable(session) == 1 then
        cmd('silent! ' .. (auto_session_plugin and cmd_plugin or cmd_custom))
        return true
    end

    return false
end

--[[
Load the current dir's session if there is one, otherwise starts Dashboard.
]]--
function _G.load_session_or_dashboard()
    local has_arguments = (fn.argc() ~= 0)
    local provider      = session_autoload_provider
    local plugin        = (provider == 'auto-session')
    local autoload      = (provider ~= nil)

    if not has_arguments and (not autoload or not load_cwd_session(plugin)) then
        load_dashboard()
    end
end

