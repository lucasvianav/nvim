local M = {}

local fn = vim.fn

--[[
Wrapper for `vim.api.nvim_replace_termcodes`. Same as escaping a key code in VimL ('t' for 'termcodes').

e.g.: t'<Esc>' in lua is the same as "\<Esc>" in VimL.
]]
function M.termcode(key)
    return vim.api.nvim_replace_termcodes(key, true, true, true)
end



local function getName(arg)
    local name = ''

    local re = {
        leadingPath = [[^.\+\/]], -- matches leading path
        extension = [[\.[^.]\+$]], -- matches trailing extension

        vim = [[[-_]n\?vim\|n\?vim]] .. '[-_]', -- matches "-vim" or "vim-" (also nvim and _)
        lua = [[[-_]n\?lua\|n\?lua]] .. '[-_]', -- matches "-lua" or "lua-" (also _)
    }

    local function subs(regex)
        return fn.substitute(name, re[regex], '', 'g')
    end

    name = arg:lower()
    name = subs('leadingPath')
    name = subs('extension')
    name = subs('vim')
    name = subs('lua')

    return name
end

local function getPath(arg)
    local path = arg
    local plugins_dir = fn.expand('$HOME/nvim-plugins/')
    local implicit_path = [[^[^\~/.]\+\|^\[^\/]*$]*$\|^\[^\~/]*]]

    if vim.regex(implicit_path):match_str(path) then
        path = plugins_dir .. path
    end

    return path
end

--[[
@param `use`   (function) -- `packer.use`
@param `dir`   (string)   -- directory in which to search for config files

@return function -- wrapper for `use`
]]
function M.get_packer_use_wrapper(use, dir)
    local theme = (dir == 'themes')

    local function getRequireString(module, pluginName)
        local requireString = [[    pcall(require, ']] .. module .. [[')]]

        if theme and pluginName then
            local comm = fn.substitute(appearanceCommands, [[.\+]], '[[&]]', '')

            requireString = requireString
                .. [[

            if colorscheme == ']]
                .. pluginName
                .. [[' then
                vim.cmd('colorscheme ]]
                .. pluginName
                .. [[')
                vim.cmd(]]
                .. comm
                .. [[)
            end
            ]]
        end

        return requireString
    end

    --[[
    Wrapper for `packer.use`.

    @param args (table) -- same as for `packer.use`
    @param opts  (table)
        @param opts.setup   (boolean) -- default to setup instead of config
        @param opts.dev (boolean) -- is it a local plugin (in dev)
        @param opts.fallback (string) -- git plugin
    ]]
    local function _use(args, opts)
        if not args or #args == 0 or not args[1] then
            return
        end
        opts = opts or {}

        local pluginName = args.as or getName(args[1])

        if opts.dev then
            args[1] = getPath(args[1])

            if fn.isdirectory(args[1]) == 0 then
                if opts.fallback then
                    args[1] = opts.fallback
                    pluginName = args.as or getName(args[1])
                else
                    vim.notify(
                        'The plugin "'
                            .. pluginName
                            .. '" was not found at: "'
                            .. args[1]
                            .. '". And no fallback was provided.',
                        'error'
                    )

                    return
                end
            end
        end

        if not args.config or (opts.setup and not args.setup) then
            local type = theme and '' or 'plugins.'
            local config_filepath = type .. dir .. '.' .. pluginName
            local requireString = getRequireString(config_filepath, pluginName)

            if opts.setup then
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
@param module (string) -- module to be loaded

@return function -- function that'll require the module
]]
function M.loadfile(module)
    return function()
        return require(module)
    end
end

--[[
Inspect contents of an object. Wraps `print(vim.inspect(args))`.

@sources:
- https://github.com/akinsho/dotfiles/blob/148d1b720b296ad9ef6943da4e7b9d2c4f86c59b/.config/nvim/lua/as/globals.lua#L93-L109
- https://www.reddit.com/r/neovim/comments/p84iu2/useful_functions_to_explore_lua_objects/

@vararg any
]]
function M.inspect(...)
    local objects, v = {}, nil
    for i = 1, select('#', ...) do
        v = select(i, ...)
        table.insert(objects, vim.inspect(v, {
            indent = '    ',
            depth = 4,
        }))
    end

    print(table.concat(objects, '\n'))
    return ...
end

--[[
Dump contents of an object below the cursor. Wraps `print(vim.inspect(args))`.

@sources:
- https://github.com/akinsho/dotfiles/blob/148d1b720b296ad9ef6943da4e7b9d2c4f86c59b/.config/nvim/lua/as/globals.lua#L93-L109
- https://www.reddit.com/r/neovim/comments/p84iu2/useful_functions_to_explore_lua_objects/

@vararg any
]]
function M.dump_text(...)
    local objects, v = {}, nil
    for i = 1, select('#', ...) do
        v = select(i, ...)
        table.insert(objects, vim.inspect(v))
    end

    local lines = vim.split(table.concat(objects, '\n'), '\n')
    local lnum = vim.api.nvim_win_get_cursor(0)[1]
    vim.fn.append(lnum, lines)
    return ...
end

--[[
Reload a lua module using Plenary.
]]
function M.reload(module)
    local is_plenary_loaded, plenary = pcall(require, 'plenary.reload')

    if is_plenary_loaded then
        plenary.reload_module(module)
        return require(module)
    else
        return nil
    end
end

--[[
Returns a function to require files inside `dir`.
]]
function M.get_require_submodule(dir)
    if not dir then
        return nil
    end

    --[[
        Requires `file` inside `dir`.
    ]]
    return function(file)
        return require(dir .. '.' .. file)
    end
end

return M
