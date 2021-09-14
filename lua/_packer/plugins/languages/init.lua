local M = {}

function M.getAll(use)
    local _use = get_packer_use_wrapper(use, '_packer.plugins.languages')

    _use({ 'lervag/vimtex', ft = { 'plaintex', 'tex' } }) -- work well with LaTeX
end

return M


