local wrappers = require('v.utils.wrappers')

function _G.t(key)
    return wrappers.termcode(key)
end

function _G.R(module)
    return wrappers.reload(module)
end

function _G.P(...)
    return wrappers.inspect(...)
end

function _G.contains(x, list)
    for _, y in pairs(list) do
        if x == y then
            return true
        end
    end

    return false
end
