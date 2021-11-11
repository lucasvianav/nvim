-- TODO: https://github.com/akinsho/dotfiles/blob/472005850403594c57fba5736a71760aae9b5e2e/.config/nvim/lua/as/plugins/init.lua#L597-L614

local notify = require('notify')
notify.setup({ stages = 'slide' })

vim.notify = notify

require('v.utils.commands').command(
    'Notifications',
    [[
        lua require("telescope").extensions.notify.notify(
            require("telescope.themes").get_dropdown({})
        )
    ]]
)
