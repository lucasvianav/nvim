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

    _use({ 'kyazdani42/nvim-web-devicons', as = 'devicons' }) -- colored icons
    _use({ 'SmiteshP/nvim-gps', after = 'nvim-treesitter' }) -- show treesitter context

    -- TODO: https://github.com/akinsho/bufferline.nvim/issues/195
    -- TODO: make a PR to only show current buffer's full filepath + tabs
    -- _use({ 'akinsho/nvim-bufferline.lua', after = 'devicons' }) -- fancy bufferline
    _use({
        'crispgm/nvim-tabline',
        -- event = {
        --     'TabNew',
        --     'TabEnter',
        --     'SessionLoadPost',
        -- },
    })

    _use({ 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' }) -- color matching surroundings using treesitter
    _use({ 'norcalli/nvim-colorizer.lua', event = 'CursorHold' }) -- highlight color codes
    _use({ 'xiyaowong/nvim-transparent', disable = true }) -- transparent background

    -- fancy statusline
    _use({
        'NTBBloodbath/galaxyline.nvim',
        after = {
            'devicons',
            'nvim-gps',
        },
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
