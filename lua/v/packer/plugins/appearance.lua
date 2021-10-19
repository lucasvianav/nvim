--[[ TODO: look into this
    https://github.com/edluffy/hologram.nvim
    https://www.reddit.com/r/neovim/comments/pv4ujz/is_there_a_way_to_see_images_in_neovim/

    global status bar:
    https://github.com/windwp/floatline.nvim
    https://github.com/windwp/windline.nvim
    https://www.reddit.com/r/neovim/comments/pxkf16/windlinenvim_one_global_status_line_on_floating/
]]

local M = {
    { 'rcarriga/nvim-notify'      }, -- beautiful notifications
    { 'kwkarlwang/bufresize.nvim' }, -- preserve window sizes on terminal resize
    { 'crispgm/nvim-tabline'      }, -- display opened tabs (2+)

    { 'kyazdani42/nvim-web-devicons', as    = 'devicons'        }, -- colored icons
    { 'p00f/nvim-ts-rainbow',         after = 'nvim-treesitter' }, -- colored matching brackets

    -- TODO: maybe swap for RRethy/vim-hexokinase
    { 'norcalli/nvim-colorizer.lua',  event = 'CursorHold'      }, -- colored color codes

    -- indent lines
    {
        'lukas-reineke/indent-blankline.nvim',
        after = 'nvim-treesitter',
    },

    -- fancy statusline
    {
        'NTBBloodbath/galaxyline.nvim',
        after = { 'devicons' },
        commit = 'f8c3653f34f8993a1aff1a7fad7052c11e75cfbe',
    },

    -- show cursor context in statusline
    {
        'SmiteshP/nvim-gps',
        after = 'nvim-treesitter',
        disable = true,
    },
}

return M
