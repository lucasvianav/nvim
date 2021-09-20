local M = {}

function M.getAll(use)
    local _use = get_packer_use_wrapper(use, '_packer.plugins.appearance')

    _use({ 'rcarriga/nvim-notify' }) -- better notifications

    _use({ 'akinsho/nvim-bufferline.lua',  after   = 'devicons'        }) -- fancy bufferline
    _use({ 'kyazdani42/nvim-web-devicons', as      = 'devicons'        }) -- colored icons
    _use({ 'norcalli/nvim-colorizer.lua',  event   = 'BufNew'          }) -- highlight color codes
    _use({ 'p00f/nvim-ts-rainbow',         after   = 'nvim-treesitter' }) -- color matching surroundings using treesitter
    _use({ 'xiyaowong/nvim-transparent',   disable = true,             }) -- transparent background
    _use({ 'SmiteshP/nvim-gps',            after   = 'nvim-treesitter' }) -- show treesitter context

    -- fancy statusline
    _use({
        'NTBBloodbath/galaxyline.nvim',
        after = {
            'devicons',
            'nvim-gps',
        },
    })

    -- indentation rulers
    _use({
        'lukas-reineke/indent-blankline.nvim',
        after = 'nvim-treesitter',
    })

    -- smooth scrolling
    _use({
        'karb94/neoscroll.nvim',
        disable = true,
        keys = {
            '<C-u>', '<C-d>', '<C-b>', '<C-f>',
            '<C-y>', '<C-e>', 'zt', 'zz', 'zb',
        },
    })
end

return M

