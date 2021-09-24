local fn = vim.fn
local cmd = vim.cmd

local loaded, packer = pcall(require, 'packer')
local packer_path    = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
local exists         = (fn.isdirectory(packer_path) == 1)

if not loaded and not exists then
    fn.delete(packer_path, 'rf')
    fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim',
        packer_path,
    })

    loaded, packer = pcall(require, 'packer')
end

