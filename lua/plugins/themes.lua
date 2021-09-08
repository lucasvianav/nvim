function _themeConfig(themes) return require('plugins.themes-config.' .. themes) end

local M = {}

function M.getAll(use)
    -- Transparent Background
    use({
        'xiyaowong/nvim-transparent',
        disable = true,
        config = function() _themeConfig('transparent') end,
    }) 

    -- DoomEmacs' One
    use({
        'NTBBloodbath/doom-one.nvim',
        cond = [[ colorscheme == 'doom-one' ]],
        config = function() _themeConfig('doom') end,
    }) 

    -- Atom's OneDark
    use({
        'navarasu/onedark.nvim',
        cond = [[ colorscheme == 'onedark' ]],
        config = function() _themeConfig('onedark') end,
    }) 

    -- TokyoNight
    use({
        'folke/tokyonight.nvim',
        cond = [[ colorscheme == 'tokyonight' ]],
        config = function() _themeConfig('tokyonight') end,
    }) 

    -- Nord
    use({
        'shaunsingh/nord.nvim',
        cond = [[ colorscheme == 'nord' ]],
        config = function() _themeConfig('nord') end,
    }) 

    -- Solarized
    use({
        'ishan9299/nvim-solarized-lua',
        cond = [[ colorscheme == 'solarized' ]],
        config = function() _themeConfig('solarized') end,
    }) 

    -- SpaceEmacs
    use({
        'Th3Whit3Wolf/space-nvim',
        cond = [[ colorscheme == 'space-nvim' ]],
        config = function() _themeConfig('space') end,
    }) 

    -- Material Design-based
    use({
        'marko-cerovac/material.nvim',
        cond = [[ colorscheme == 'material' ]],
        config = function() _themeConfig('material') end,
    }) 
end

return M

