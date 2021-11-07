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
