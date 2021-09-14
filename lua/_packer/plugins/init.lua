local M = {}

function M.getAll(use)
    local function plugins(module)
        return require('_packer.plugins.' .. module).getAll(use)
    end

    plugins('general')
    plugins('syntax')
    plugins('lsp')
    plugins('appearance')
    plugins('git')
    plugins('navigation')
end

return M

