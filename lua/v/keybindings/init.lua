local req_submodule = require('v.utils.wrappers').get_require_submodule('keybindings')

local M = {
    general    = req_submodule('general'),
    navigation = req_submodule('navigation'),
    shortcuts  = req_submodule('shortcuts'),
    unmappings = req_submodule('unmappings'),
}

return M
