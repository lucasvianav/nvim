local fn = vim.fn
local cmd = vim.cmd

local present, packer = pcall(require, "packer")

if not present then
    local packer_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

    vim.fn.delete(packer_path, "rf")
    fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim',
        packer_path,
    })

    present, packer = pcall(require, "packer")
end

local function getAll(use)
    require('_packer.plugins').getAll(use)
    require('_packer.themes').getAll(use)
end

return present and packer.startup(getAll) or nil

