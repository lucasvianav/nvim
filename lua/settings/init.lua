local function settings(file)
    return require('settings.' .. file)
end

local M = {
    general    = settings('general'),
    appearance = settings('appearance'),
    folding    = settings('folding'),
    macros     = settings('macros'),
    providers  = settings('providers'),
}

return M

