local req_submodule = require('v.utils.wrappers').get_require_submodule('v.packer.plugins')

local M = {
    general    = req_submodule('general'),
    syntax     = req_submodule('syntax'),
    lsp        = req_submodule('lsp'),
    appearance = req_submodule('appearance'),
    git        = req_submodule('git'),
    navigation = req_submodule('navigation'),
}

return M

