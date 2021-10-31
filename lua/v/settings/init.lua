local req_submodule = require('v.utils.wrappers').get_require_submodule('v.settings')

local M = {
    general = req_submodule('general'),
    appearance = req_submodule('appearance'),
    providers = req_submodule('providers'),
    builtin = req_submodule('builtin'),
}

return M
