local function settings(file)
    return require('settings.' .. file)
end

local M = {
    general    = settings('general'),
    appearance = settings('appearance'),
    folding    = settings('folding'),
    providers  = settings('providers'),
    sessions   = settings('sessions'),
    builtin    = settings('builtin'),
}

return M

