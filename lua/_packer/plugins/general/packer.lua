local packer = require('packer')

local function getAll(use, use_rocks)
    require('_packer.plugins').getAll(use)
    require('_packer.themes').getAll(use)
    require('_packer.luarocks').getAll(use_rocks)
end

packer.init({
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'single' })
        end,
        prompt_border = 'single',
    },
})

getAll(packer.use, packer.use_rocks)
