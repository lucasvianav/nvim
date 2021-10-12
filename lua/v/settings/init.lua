local req_submodule = require('v.utils.wrappers').get_require_submodule('settings')

local M = {
    general    = req_submodule('general'),
    appearance = req_submodule('appearance'),
    folding    = req_submodule('folding'),
    providers  = req_submodule('providers'),
    sessions   = req_submodule('sessions'),
    builtin    = req_submodule('builtin'),
}

return M

