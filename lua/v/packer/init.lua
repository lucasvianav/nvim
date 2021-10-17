local fn = vim.fn
local utils = require('v.utils.packer')

local is_loaded, packer = utils.get_packer()
local exists = (fn.isdirectory(utils.packer_path) == 1)

if not is_loaded and not exists then
    vim.notify('Downloading Packer...', nil, { title = 'Packer' })

    fn.delete(utils.packer_path, 'rf')
    fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        utils.packer_path,
    })

    is_loaded, packer = utils.get_packer()

    utils.setup(packer)
    packer.sync()
end
