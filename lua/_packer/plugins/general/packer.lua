local packer = require('packer')

local function getAll(use)
    require('_packer.plugins').getAll(use)
    require('_packer.themes').getAll(use)
end

packer.init({
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'single' })
        end,
        prompt_border = 'single',
    },
})

getAll(packer.use)
