local M = {}

function M.getAll(use)
    local _use = get_packer_use_wrapper(use, '_packer.plugins.appearance')

    _use({ 'rcarriga/nvim-notify' }) -- better notifications

    _use({ 'kyazdani42/nvim-web-devicons', as      = 'devicons' }) -- colored icons
    _use({ 'norcalli/nvim-colorizer.lua',  event   = 'BufRead'  }) -- highlight color codes
    _use({ 'xiyaowong/nvim-transparent',   disable = true,      }) -- transparent background
    _use({ 'folke/twilight.nvim',          cmd     = 'Twilight' }) -- dims inactive portions of the code

    -- color matching surroundings using treesitter
    _use({
        'p00f/nvim-ts-rainbow',
        event   = 'BufRead',
        after = 'nvim-treesitter',
    }) 

    -- fancy bufferline
    _use({
        'akinsho/nvim-bufferline.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        after = 'devicons',
    })

    -- fancy statusline
    _use({
        'glepnir/galaxyline.nvim',
        branch = 'main',
        requires = {'kyazdani42/nvim-web-devicons'},
        after = 'devicons',
    })

    -- indentation rulers
    _use({
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufRead',
    })

    -- smooth scrolling
    _use({
        'karb94/neoscroll.nvim',
        keys = {
            '<C-u>', '<C-d>', '<C-b>', '<C-f>',
            '<C-y>', '<C-e>', 'zt', 'zz', 'zb',
        },
    })
end

return M

