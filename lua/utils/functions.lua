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

--[[
@param `use`   (function) -- `packer.use`
@param `dir`   (string)   -- directory in which to search for config files
@param `theme` (boolean)  -- is it a theme?

@return wrapper for `use`
]]--
function _G.get_packer_use_wrapper(use, dir, theme)
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
                leadingPath = [[^.\+\/]],    -- matches leading path
                extension   = [[\.[^.]\+$]], -- matches trailing extension

                vim         = [[[-_]n\?vim\|n\?vim]] .. '[-_]', -- matches "-vim" or "vim-" (also nvim and _)
                lua         = [[[-_]n\?lua\|n\?lua]] .. '[-_]', -- matches "-lua" or "lua-" (also _)
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
            local config_filepath = dir .. '.' .. pluginName
            local requireString = getRequireString(config_filepath, pluginName)

            if setup then
                args.setup = requireString
            else
                args.config = requireString
            end
        end

        if theme and pluginName and not args.cond then
            args.cond = [[colorscheme == ']] .. pluginName .. [[']]
        end

        return use(args)
    end

    return _use
end

--[[
Checks if `list` contains the element `x` using binary search. Only useful if `list` is sorted.
]]--
function _G.containsBin(x, list)
    local middle
    local start = 1
    local size = #list

    while(start <= size) do
        middle = math.floor((start + size)/2)

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
]]--
function _G.contains(x, list)
    for _, y in pairs(list) do
        if x == y then return true end
    end

    return false
end

--[[
Same as escaping a key code in VimL ('t' for 'termcodes').

e.g.: t'<Esc>' in lua is the same as "\<Esc>" in VimL.
]]--
function _G.t(key)
    return vim.api.nvim_replace_termcodes(key, true, true, true)
end
