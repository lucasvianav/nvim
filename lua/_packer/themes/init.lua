local M = {}

function M.getAll(use)
    local _use = get_packer_use_wrapper(use, '_packer.themes', true)

    _use({ 'NTBBloodbath/doom-one.nvim'   })     -- DoomEmacs' One
    _use({ 'navarasu/onedark.nvim'        })     -- Atom's OneDark
    _use({ 'folke/tokyonight.nvim'        })     -- TokyoNight
    _use({ 'shaunsingh/nord.nvim'         })     -- Nord
    _use({ 'ishan9299/nvim-solarized-lua' })     -- Solarized
    _use({ 'Th3Whit3Wolf/space-nvim'      })     -- SpaceEmacs
    _use({ 'marko-cerovac/material.nvim'  })     -- Material Design-based
end

return M

