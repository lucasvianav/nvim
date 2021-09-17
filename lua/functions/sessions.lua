local fn = vim.fn
local cmd = vim.cmd

local function get_cwd_session_path()
    local expanded_sessions_dir = fn.expand(sessions_dir)
    local escaped_cwd           = fn.fnamemodify(fn.getcwd(), [[:~:s?\~/??:gs?/?_?]])

    return expanded_sessions_dir .. escaped_cwd .. '.vim'
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
function _G.load_cwd_session()
    local session = get_cwd_session_path()

    if fn.filereadable(session) == 1 then
        cmd('source ' .. session)
        return true
    end

    return false
end

--[[
Load the current dir's session if there is one, otherwise starts Dashboard.
]]--
function _G.load_session_or_dashboard()
    local has_arguments = (fn.argc() ~= 0)
    local autoload      = session_autoload_enabled

    if not has_arguments and (not autoload or not load_cwd_session()) then
        load_dashboard()
    end
end

