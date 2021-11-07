-- update lightbulb whenever cursor stops
require('v.utils.autocmds').augroup('LspLightbulb', {
    {
        { 'CursorHold', 'CursorHoldI' },
        '*',
        'lua require("nvim-lightbulb").update_lightbulb()',
    }
})
