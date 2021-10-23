-- TODO: https://github.com/danielnehrig/nvim/blob/master/lua/plugins/dashboard/init.lua

require('v.utils').set_viml_options('dashboard', {
    disable_at_vimenter = 1, -- I open it manually
    disable_statusline  = 1,
    default_executive   = 'telescope',

    custom_header = require('v.utils').ascii.beholder,

    custom_section = {
        a = {
            description = { '  Find File                 SPC f f' },
            command = 'Telescope find_files',
        },
        b = {
            description = { '  Grep                      SPC f p' },
            command = 'Telescope live_grep',
        },
        c = {
            description = { '洛 New File                  CMD ene' },
            command = 'DashboardNewFile',
        },
    },

    custom_footer = { '      ' },
})
