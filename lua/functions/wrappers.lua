local fn =  vim.fn

--[[
Wrapper for `vim.api.nvim_replace_termcodes`. Same as escaping a key code in VimL ('t' for 'termcodes').

e.g.: t'<Esc>' in lua is the same as "\<Esc>" in VimL.
]]--
function _G.t(key)
    return vim.api.nvim_replace_termcodes(key, true, true, true)
end

--[[
@param `use`   (function) -- `packer.use`
@param `dir`   (string)   -- directory in which to search for config files
@param `theme` (boolean)  -- is it a theme?

@return function -- wrapper for `use`
]]--
-- TODO: finish implementing local _use
function _G.get_packer_use_wrapper(use, dir, theme)
    local function getRequireString(module, pluginName)
        local requireString = [[    pcall(require, ']] .. module .. [[')]]

        if theme and pluginName then
            local comm = fn.substitute(appearanceCommands, [[.\+]], '[[&]]', '')

            requireString = requireString .. [[

            if colorscheme == ']] .. pluginName .. [[' then
                vim.cmd('colorscheme ]] .. pluginName .. [[')
                vim.cmd(]] .. comm .. [[)
            end
            ]]
        end

        return requireString
    end

    --[[
    Wrapper for `packer.use`.

    @param args (table) -- same as for `packer.use`
    @param opt  (table)
        @param opt.setup   (boolean) -- default to setup instead of config
        @param opt.boolean (boolean) -- is it a local plugin
    ]]--
    -- local function _use(args, opt)
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

        -- if not args.config or (opt.setup and not args.setup) then
        --     local config_filepath = dir .. '.' .. pluginName
        --     local requireString = getRequireString(config_filepath, pluginName)

        --     if opt.setup then
        --         args.setup = requireString
        --     else
        --         args.config = requireString
        --     end
        -- end

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

        -- if opt.local then
        --     if vim.regex([[^\[^/]*$\|^\[^~/]*]]):match_str(args[0]) then
        --     else
        --     end
        -- end

        return use(args)
    end

    return _use
end

--[[
@param module (string) -- module to be loaded

@return function -- function that'll require the module
]]--
function _G._loadfile(module)
    return function() return require(module) end
end

--[[
Wrapper for `print(vim.inspect(args))` for each argument.
]]--
function _G.inspect(...)
    local args = { ... }

    for _, arg in pairs(args) do
        print(vim.inspect(arg, { indent = '    ', depth = 4 }))
    end
end

--[[
Reload a lua module using Plenary.
]]--
-- TODO: checkout https://github.com/lukas-reineke/dotfiles/blob/5b84e9264d3ca9e40fd773642e5a1d335224733e/vim/lua/utils.lua#L62-L65
function _G.R(module)
    require('plenary.reload').reload(module)
    return require(module)
end

