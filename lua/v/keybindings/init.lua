local req_submodule = require('v.utils.wrappers').get_require_submodule('keybindings')

local M = {
    unmappings = req_submodule('unmappings'),
    general    = req_submodule('general'),
    navigation = req_submodule('navigation'),
}

return M
