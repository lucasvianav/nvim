local fn = vim.fn
local utils = require('v.utils.packer')

local is_loaded, packer = utils.get_packer()
local exists = (fn.isdirectory(utils.path) == 1)

if not is_loaded and not exists then
    vim.notify('Downloading Packer...', nil, { title = 'Packer' })

    fn.delete(utils.path, 'rf')
    fn.delete(utils.compile_path, 'rf')
    fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        utils.path,
    })

    is_loaded, packer = utils.get_packer()

    if is_loaded then
        utils.setup(packer)
        packer.sync()
    else
        vim.api.nvim_notify('Shit happened.', vim.log.levels.ERROR, { title = 'Packer' })
    end
else
    pcall(require, 'packer_compiled')
end
