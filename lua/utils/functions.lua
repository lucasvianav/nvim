local fn = vim.fn
local cmd = vim.cmd

function _G.map(mode, lhs, rhs, opt)
    local available_modes = 'nvsxo!ilct'
    if #mode ~= 1 or not string.find(available_modes, mode) then return end

    local options = vim.tbl_extend('force', { noremap = true, silent = true }, opt or {})
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)

    return options
end

function _G.unmap(mode, lhs)
    vim.api.nvim_set_keymap(mode, lhs, '<nop>', {})
end

function _G._loadfile(module)
    return function() return require(module) end
end

function _G.loadSessionOrDashboard()
    local sessionsDir = fn.expand('~/.local/share/nvim/sessions/')
    local cwd = fn.expand(fn.getcwd())
    local session = sessionsDir .. fn.substitute(cwd, '/', '\\%', 'g') .. '.vim'
    local noArguments = vim.fn.argc()

    if fn.filereadable(session) == 1 then
        cmd('silent! RestoreSession')
    elseif noArguments == 0 then
        cmd('silent! Dashboard')
    end
end

function _G.getLoadFunction(type, use)
    local plugin = type == 'plugin'
    local theme  = type == 'theme'
    if (not plugin and not theme) or not use then return end

    local function getRequireString(module, pluginName)
        local requireString = [[    pcall(require, ']] .. module .. [[')]]

        if theme and pluginName then
            local comm = vim.fn.substitute(appearanceCommands, [[.\+]], '[[&]]', '')

            requireString = requireString .. [[
            
                if colorscheme == ']] .. pluginName .. [[' then
                    vim.cmd('colorscheme ]] .. pluginName .. [[') 
                    vim.cmd(]] .. comm .. [[)
                end
            ]]
        end

        return requireString
    end

    local function _use(args, setup)
        if not args or #args == 0 or not args[1] then return end

        local pluginName = args.as

        if not pluginName then
            local re = {
                leadingPath = [[^.\+\/]],           -- matches leading path
                extension   = [[\.[^.]\+$]],        -- matches trailing extension
                vim         = [[-n\?vim\|n\?vim-]], -- matches "-vim" or "vim-" (also nvim)
                lua         = [[-n\?lua\|n\?lua-]], -- matches "-lua" or "lua-"
            }

            local function subs(regex) 
                return fn.substitute(pluginName, re[regex], '', 'g')
            end

            pluginName = args[1]:lower()
            pluginName = subs('leadingPath')
            pluginName = subs('extension')
            pluginName = subs('vim')
            pluginName = subs('lua')
        end

        if not args.config or (setup and not args.setup) then
            local module = 'plugins.' .. type .. 's-config.' .. pluginName
            local requireString = getRequireString(module, pluginName)

            if setup then
                args.setup = requireString
            else
                args.config = requireString
            end
        end

        if theme and pluginName and not args.cond then
            args.cond = [[colorscheme == ']] .. pluginName .. [[']]
        end

        -- print(pluginName, type, plugin, theme)
        -- print(vim.inspect(args))

        return use(args)
    end

    return _use
end

