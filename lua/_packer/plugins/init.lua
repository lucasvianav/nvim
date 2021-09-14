local M = {}

function M.getAll(use)
    local function plugins(module)
        return require('_packer.plugins.' .. module).getAll(use)
    end

    plugins('general')
    plugins('appearance')
    plugins('git')
    plugins('syntax')
    plugins('lsp')
    plugins('navigation')
end

return M

