local M = {}

--[[ TODO:
    lucasvianav/twilight.nvim (locally)
    + fix it --> issue #15 (https://github.com/folke/twilight.nvim/issues/15)

    look into this
    https://github.com/edluffy/hologram.nvim
    https://www.reddit.com/r/neovim/comments/pv4ujz/is_there_a_way_to_see_images_in_neovim/
]]
function M.getAll(use)
    local _use = get_packer_use_wrapper(use, '_packer.plugins.appearance')

    _use({ 'rcarriga/nvim-notify' }) -- better notifications
    _use({ 'kwkarlwang/bufresize.nvim' }) -- preserve window sizes on terminal resize
    _use({ 'crispgm/nvim-tabline' }) -- display onepened tabs (2+)

    _use({ 'kyazdani42/nvim-web-devicons', as = 'devicons' }) -- colored icons

    -- show treesitter context
    _use({
        'SmiteshP/nvim-gps',
        after = 'nvim-treesitter',
        disable = true,
    })

    _use({ 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' }) -- color matching surroundings using treesitter
    _use({ 'norcalli/nvim-colorizer.lua', event = 'CursorHold' }) -- highlight color codes
    _use({ 'xiyaowong/nvim-transparent', disable = true }) -- transparent background

    -- fancy statusline
    _use({
        'NTBBloodbath/galaxyline.nvim',
        after = { 'devicons' },
        commit = 'f8c3653f34f8993a1aff1a7fad7052c11e75cfbe',
    })

    -- indentation rulers
    -- TODO: test Kitty or Fira Code Mono
    _use({
        'lukas-reineke/indent-blankline.nvim',
        after = 'nvim-treesitter',
    })

    -- smooth scrolling
    _use({
        'karb94/neoscroll.nvim',
        disable = true,
        keys = {
            '<C-u>',
            '<C-d>',
            '<C-b>',
            '<C-f>',
            '<C-y>',
            '<C-e>',
            'zt',
            'zz',
            'zb',
        },
    })
end

return M
