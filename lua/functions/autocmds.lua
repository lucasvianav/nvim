local fn = vim.fn
local cmd = vim.cmd

--[[
Load the current dir's session if there is one, otherwise starts Dashboard.
]]--
function _G.load_session_or_dashboard()
    local sessionsDir = fn.expand('~/.local/share/nvim/sessions/')
    local cwd = fn.expand(fn.getcwd())
    local session = sessionsDir .. fn.substitute(cwd, '/', '\\%', 'g') .. '.vim'
    local noArguments = vim.fn.argc()

    if fn.filereadable(session) == 1 then
        cmd('silent! RestoreSession')
        cmd('silent! windo e')
    elseif noArguments == 0 then
        cmd('silent! Dashboard')
    end
end

