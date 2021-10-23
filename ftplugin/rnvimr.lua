local opts = {
    nowait = true,
    buffer = true,
}

require('v.utils.mappings').map('t', 'j', 'j', opts)
require('v.utils.mappings').map('t', 'k', 'k', opts)
