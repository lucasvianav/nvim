local fn = vim.fn
local cmd = vim.cmd

cmd('packadd packer.nvim')

local present, packer = pcall(require, "packer")

if not present then
    local packer_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

    vim.fn.delete(packer_path, "rf")
    fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim',
        packer_path,
    })

    cmd('packadd packer.nvim')
    present, packer = pcall(require, "packer")
end

local plugins = require('plugins.plugins')

return present and packer.startup(plugins.getAll) or nil
