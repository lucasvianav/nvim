local fn = vim.fn
local cmd = vim.api.nvim_command

local M = {}

-- TODO: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/utils/plugins.lua

M.path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

--- Loads packer.nvim (since it's lazy-loaded) and pcall requires it.
function M.get_packer()
    cmd('packadd packer.nvim')
    local is_loaded, packer = pcall(require, 'packer')

    return is_loaded, packer
end

function M.bootstrap()
    local is_loaded, packer = M.get_packer()
    local exists = (fn.isdirectory(M.packer_path) == 1)

    if not is_loaded and not exists then
        vim.notify('Downloading Packer...', nil, { title = 'Packer' })

        fn.delete(M.packer_path, 'rf')
        fn.system({
            'git',
            'clone',
            '--depth',
            '1',
            'https://github.com/wbthomason/packer.nvim',
            M.packer_path,
        })

        cmd('packadd packer.nvim')
        is_loaded, packer = pcall(require, 'packer')

        require('_packer.plugins.general.packer')
        packer.sync()
    end
end

function M.setup()
    local is_loaded, packer = M.get_packer()

    packer.init({
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end,
            prompt_border = 'single',
        },
    })

    require('v.packer.plugins').getAll(packer.use)
    require('v.packer.themes').getAll(packer.use)
end

return M
